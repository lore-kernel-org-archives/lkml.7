Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BD6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E3B21556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888934;
	bh=qatBiUoJgLVyhApb5IdaSM3wrONFuruow8EtSDXjdT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVUIR0aou2N92WAxz4+l/5iKU+3jZwZ60UYvJ5981/arTKLySRo8FAg5ECUfOumnJ
	 zk9fR9MuyckvP2vZPdabfxTY6uVbS1zPgex8eiiyPYCMeAnp3T9P6y/VVMHlANk1ug
	 f+qcARBUIqJVCfumSM2OK0A+C/1cvkqRBHPSX2A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfK0VIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732791AbfK0VIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:08:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463EE21774;
        Wed, 27 Nov 2019 21:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888925;
        bh=qatBiUoJgLVyhApb5IdaSM3wrONFuruow8EtSDXjdT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKb5C0ykDuXK0U4RDJgl0ZeUUvnlntTtjKMOpsgziYPXnUeryvYlL60pPrKmTDWi6
         ihlL5ewvutLiZCRReV/tfxGWaAAeiUIfJLFfC/556Ml9KQMppRaGW5ea9N/ue8O+qH
         0djCSB3xBPpsUXISkTSLQpbSkt4yxZGt+e+8CP94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shani Shapp <shanish@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.3 17/95] net/mlx5: Update the list of the PCI supported devices
Date:   Wed, 27 Nov 2019 21:31:34 +0100
Message-Id: <20191127202850.297706293@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shani Shapp <shanish@mellanox.com>

[ Upstream commit b7eca940322f47fd30dafb70da04d193a0154090 ]

Add the upcoming ConnectX-6 LX device ID.

Fixes: 85327a9c4150 ("net/mlx5: Update the list of the PCI supported devices")
Signed-off-by: Shani Shapp <shanish@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1552,6 +1552,7 @@ static const struct pci_device_id mlx5_c
 	{ PCI_VDEVICE(MELLANOX, 0x101c), MLX5_PCI_DEV_IS_VF},	/* ConnectX-6 VF */
 	{ PCI_VDEVICE(MELLANOX, 0x101d) },			/* ConnectX-6 Dx */
 	{ PCI_VDEVICE(MELLANOX, 0x101e), MLX5_PCI_DEV_IS_VF},	/* ConnectX Family mlx5Gen Virtual Function */
+	{ PCI_VDEVICE(MELLANOX, 0x101f) },			/* ConnectX-6 LX */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */


