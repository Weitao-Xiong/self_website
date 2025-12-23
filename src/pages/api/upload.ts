import fs from "node:fs/promises";
import path from "node:path";
import type { APIRoute } from "astro";

export const POST: APIRoute = async ({ request }) => {
	try {
		const formData = await request.formData();
		const file = formData.get("file") as File;
		const folder = (formData.get("folder") as string) || "images";

		if (!file) {
			return new Response(JSON.stringify({ error: "No file provided" }), {
				status: 400,
				headers: { "Content-Type": "application/json" },
			});
		}

		const buffer = await file.arrayBuffer();
		const fileName = file.name;
		const uploadPath = path.join(
			process.cwd(),
			"src",
			"assets",
			folder,
			fileName,
		);

		// 确保目录存在
		await fs.mkdir(path.dirname(uploadPath), { recursive: true });

		// 写入文件
		await fs.writeFile(uploadPath, Buffer.from(buffer));

		// 返回文件路径
		const publicPath = `/src/assets/${folder}/${fileName}`;

		return new Response(
			JSON.stringify({
				url: publicPath,
				path: publicPath,
			}),
			{
				status: 200,
				headers: { "Content-Type": "application/json" },
			},
		);
	} catch (error) {
		console.error("Upload error:", error);
		return new Response(JSON.stringify({ error: "Upload failed" }), {
			status: 500,
			headers: { "Content-Type": "application/json" },
		});
	}
};
