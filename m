Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC32C50718
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF2524712
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfLMNzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:55:41 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43724 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727628AbfLMNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:55:40 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [131.188.30.136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id F066D2417CD;
        Fri, 13 Dec 2019 14:55:38 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id E2833C20BC7; Fri, 13 Dec 2019 14:55:38 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v3 05/10] PCMCIA/i82092: change code indentation
Date:   Fri, 13 Dec 2019 14:53:09 +0100
Message-Id: <20191213135311.9111-6-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213135311.9111-1-simon.geis@fau.de>
References: <20191213135311.9111-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align switch and case labels in order to improve readability.
For the same reason, change the indentation of an if-statement.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 122 ++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 16431b48fd9e..6b39750db282 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -82,22 +82,22 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 
 	pci_read_config_byte(dev, 0x40, &configbyte);  /* PCI Configuration Control */
 	switch (configbyte&6) {
-		case 0:
-			socket_count = 2;
-			break;
-		case 2:
-			socket_count = 1;
-			break;
-		case 4:
-		case 6:
-			socket_count = 4;
-			break;
-
-		default:
-			dev_err(&dev->dev,
-				"Oops, you did something we didn't think of.\n");
-			ret = -EIO;
-			goto err_out_disable;
+	case 0:
+		socket_count = 2;
+		break;
+	case 2:
+		socket_count = 1;
+		break;
+	case 4:
+	case 6:
+		socket_count = 4;
+		break;
+
+	default:
+		dev_err(&dev->dev,
+			"Oops, you did something we didn't think of.\n");
+		ret = -EIO;
+		goto err_out_disable;
 	}
 	dev_info(&dev->dev, "configured as a %d socket device.\n",
 		 socket_count);
@@ -501,42 +501,42 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 	}
 
 	switch (state->Vcc) {
-		case 0:
-			break;
-		case 50:
-			dev_info(&sock_info->dev->dev,
-				 "setting voltage to Vcc to 5V on socket %i\n",
-				 sock);
-			reg |= I365_VCC_5V;
-			break;
-		default:
-			dev_err(&sock_info->dev->dev,
-				"%s called with invalid VCC power value: %i",
-				__func__, state->Vcc);
-			leave("i82092aa_set_socket");
-			return -EINVAL;
+	case 0:
+		break;
+	case 50:
+		dev_info(&sock_info->dev->dev,
+			 "setting voltage to Vcc to 5V on socket %i\n",
+			 sock);
+		reg |= I365_VCC_5V;
+		break;
+	default:
+		dev_err(&sock_info->dev->dev,
+			"%s called with invalid VCC power value: %i",
+			__func__, state->Vcc);
+		leave("i82092aa_set_socket");
+		return -EINVAL;
 	}
 
 	switch (state->Vpp) {
-		case 0:
-			dev_info(&sock_info->dev->dev,
-				 "not setting Vpp on socket %i\n", sock);
-			break;
-		case 50:
-			dev_info(&sock_info->dev->dev,
-				 "setting Vpp to 5.0 for socket %i\n", sock);
-			reg |= I365_VPP1_5V | I365_VPP2_5V;
-			break;
-		case 120:
-			dev_info(&sock_info->dev->dev, "setting Vpp to 12.0\n");
-			reg |= I365_VPP1_12V | I365_VPP2_12V;
-			break;
-		default:
-			dev_err(&sock_info->dev->dev,
-				"%s called with invalid VPP power value: %i",
-				__func__, state->Vcc);
-			leave("i82092aa_set_socket");
-			return -EINVAL;
+	case 0:
+		dev_info(&sock_info->dev->dev,
+			 "not setting Vpp on socket %i\n", sock);
+		break;
+	case 50:
+		dev_info(&sock_info->dev->dev,
+			 "setting Vpp to 5.0 for socket %i\n", sock);
+		reg |= I365_VPP1_5V | I365_VPP2_5V;
+		break;
+	case 120:
+		dev_info(&sock_info->dev->dev, "setting Vpp to 12.0\n");
+		reg |= I365_VPP1_12V | I365_VPP2_12V;
+		break;
+	default:
+		dev_err(&sock_info->dev->dev,
+			"%s called with invalid VPP power value: %i",
+			__func__, state->Vcc);
+		leave("i82092aa_set_socket");
+		return -EINVAL;
 	}
 
 	if (reg != indirect_read(sock, I365_POWER)) /* only write if changed */
@@ -662,17 +662,17 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 
 	i = (region.end >> 12) & 0x0fff;
 	switch (to_cycles(mem->speed)) {
-		case 0:
-			break;
-		case 1:
-			i |= I365_MEM_WS0;
-			break;
-		case 2:
-			i |= I365_MEM_WS1;
-			break;
-		default:
-			i |= I365_MEM_WS1 | I365_MEM_WS0;
-			break;
+	case 0:
+		break;
+	case 1:
+		i |= I365_MEM_WS0;
+		break;
+	case 2:
+		i |= I365_MEM_WS1;
+		break;
+	default:
+		i |= I365_MEM_WS1 | I365_MEM_WS0;
+		break;
 	}
 
 	indirect_write16(sock, base+I365_W_STOP, i);
@@ -704,7 +704,7 @@ static void i82092aa_module_exit(void)
 	enter("i82092aa_module_exit");
 	pci_unregister_driver(&i82092aa_pci_driver);
 	if (sockets[0].io_base > 0)
-			 release_region(sockets[0].io_base, 2);
+		release_region(sockets[0].io_base, 2);
 	leave("i82092aa_module_exit");
 }
 
-- 
2.20.1

