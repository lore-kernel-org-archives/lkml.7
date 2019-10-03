Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4F7C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD03320673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122264;
	bh=QpJnKHFPgpxos84+p/mFe97V7DiFatCPgCd4XKYrJVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cJwE5rUzj4dfmJTSemF/Ve7i0SOoY2j/xPDiKS6L/8NPAV6QG61AW+gP3rLQZVjH
	 ZoPGeSmZuRF8t4ePEfOtbJWu+Dh+HO6vF/2U3IT05PQqzRtXsxfc+BdxI2nssbBGgU
	 VkpJYg0170v3SP6jkc3ZiB7oNYsJzrbxHc4oW0Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392819AbfJCREX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392181AbfJCQlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:41:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963EC206BB;
        Thu,  3 Oct 2019 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120868;
        bh=QpJnKHFPgpxos84+p/mFe97V7DiFatCPgCd4XKYrJVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSlgCgqbdsvHDI66d/TYpHgbimWjLq7t8/YbsbTKnfC2tG+0rPfM/JARZKHIpUVAa
         R7sIWjr0IsyK/jCVIIiYRJl3ZfIghO6fkBT5iM0ewRU4dY0A+7pLo/624U1wjat2Do
         cWpTvzHA/rGc9Rpgpw13xwdgxfCNBjMO6X7vL7ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bodong Wang <bodong@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.3 032/344] net/mlx5: Add device ID of upcoming BlueField-2
Date:   Thu,  3 Oct 2019 17:49:57 +0200
Message-Id: <20191003154543.259907936@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodong Wang <bodong@mellanox.com>

[ Upstream commit d19a79ee38c8fda6d297e4227e80db8bf51c71a6 ]

Add the device ID of upcoming BlueField-2 integrated ConnectX-6 Dx
network controller. Its VFs will be using the generic VF device ID:
0x101e "ConnectX Family mlx5Gen Virtual Function".

Fixes: 2e9d3e83ab82 ("net/mlx5: Update the list of the PCI supported devices")
Signed-off-by: Bodong Wang <bodong@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1554,6 +1554,7 @@ static const struct pci_device_id mlx5_c
 	{ PCI_VDEVICE(MELLANOX, 0x101e), MLX5_PCI_DEV_IS_VF},	/* ConnectX Family mlx5Gen Virtual Function */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
+	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */
 	{ 0, }
 };
 


