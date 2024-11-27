/**
 * 
 * Take care of Omniarium extension commands!
 * 
**/

// Imports
import * as vscode from "vscode";

// Constants
const DOCS_URL = 'https://docs.ender.ing/docs/frankie/intro/';

// Message test
export const docs = vscode.commands.registerCommand('polarfrankie.docs', () => {
    const url = vscode.Uri.parse(DOCS_URL);
    vscode.env.openExternal(url);
});