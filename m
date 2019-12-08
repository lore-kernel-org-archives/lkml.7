Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E84CC2D0BE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4707F20692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLHQUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:20:40 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49698 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfLHQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:20:37 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [131.188.30.136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id A4198241797;
        Sun,  8 Dec 2019 17:10:41 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 9374BC20BC6; Sun,  8 Dec 2019 17:10:41 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH 07/12] PCMCIA: change incorrect code indentation
Date:   Sun,  8 Dec 2019 17:09:42 +0100
Message-Id: <20191208160947.20694-8-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191208160947.20694-2-simon.geis@fau.de>
References: <20191208160947.20694-2-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 128 ++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index b9366adfe087..a2be520bc3d3 100644
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
-				"i82092aa: Oops, you did something we didn't think of.\n");
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
+			"i82092aa: Oops, you did something we didn't think of.\n");
+		ret = -EIO;
+		goto err_out_disable;
 	}
 	dev_info(&dev->dev, "i82092aa: configured as a %d socket device.\n",
 		 socket_count);
@@ -502,45 +502,45 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
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
-				"i82092aa: %s called with invalid VCC power value: %i",
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
+			"i82092aa: %s called with invalid VCC power value: %i",
+			__func__, state->Vcc);
+		leave("i82092aa_set_socket");
+		return -EINVAL;
 	}
 
 	switch (state->Vpp) {
-		case 0:
-			dev_info(&sock_info->dev->dev,
-				 "not setting Vpp on socket %i\n",
-				 sock);
-			break;
-		case 50:
-			dev_info(&sock_info->dev->dev,
-				 "setting Vpp to 5.0 for socket %i\n",
-				 sock);
-			reg |= I365_VPP1_5V | I365_VPP2_5V;
-			break;
-		case 120:
-			dev_info(&sock_info->dev->dev,
-				 "setting Vpp to 12.0\n");
-			reg |= I365_VPP1_12V | I365_VPP2_12V;
-			break;
-		default:
-			dev_err(&sock_info->dev->dev,
-				"i82092aa: %s called with invalid VPP power value: %i",
-				__func__, state->Vcc);
-			leave("i82092aa_set_socket");
-			return -EINVAL;
+	case 0:
+		dev_info(&sock_info->dev->dev,
+			 "not setting Vpp on socket %i\n",
+			 sock);
+		break;
+	case 50:
+		dev_info(&sock_info->dev->dev,
+			 "setting Vpp to 5.0 for socket %i\n",
+			 sock);
+		reg |= I365_VPP1_5V | I365_VPP2_5V;
+		break;
+	case 120:
+		dev_info(&sock_info->dev->dev,
+			 "setting Vpp to 12.0\n");
+		reg |= I365_VPP1_12V | I365_VPP2_12V;
+		break;
+	default:
+		dev_err(&sock_info->dev->dev,
+			"i82092aa: %s called with invalid VPP power value: %i",
+			__func__, state->Vcc);
+		leave("i82092aa_set_socket");
+		return -EINVAL;
 	}
 
 	if (reg != indirect_read(sock, I365_POWER)) /* only write if changed */
@@ -679,17 +679,17 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 
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
@@ -731,7 +731,7 @@ static void i82092aa_module_exit(void)
 	enter("i82092aa_module_exit");
 	pci_unregister_driver(&i82092aa_pci_driver);
 	if (sockets[0].io_base > 0)
-			 release_region(sockets[0].io_base, 2);
+		release_region(sockets[0].io_base, 2);
 	leave("i82092aa_module_exit");
 }
 
-- 
2.20.1

