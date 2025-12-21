import { visit } from "unist-util-visit";

/**
 * Rehype plugin to fix image paths in markdown content
 * Ensures images use correct base URL for deployment platforms like Zeabur
 */
export function rehypeFixImagePaths() {
	return (tree) => {
		visit(tree, (node) => {
			if (node.type === "element" && node.tagName === "img") {
				const src = node.properties?.src;
				if (src && typeof src === "string") {
					// Skip if already absolute URL or data URI
					if (src.startsWith("http://") || src.startsWith("https://") || src.startsWith("data:")) {
						return;
					}
					
					// If path starts with /, ensure it uses base URL
					if (src.startsWith("/")) {
						// Use import.meta.env.BASE_URL at build time
						const baseUrl = import.meta.env.BASE_URL || "/";
						// Remove leading slash from src if baseUrl already has one
						const normalizedSrc = baseUrl.endsWith("/") 
							? src.slice(1) 
							: src;
						// Join base URL with normalized src
						node.properties.src = baseUrl + normalizedSrc;
					}
				}
			}
		});
	};
}

