Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803AEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C14420867
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119916;
	bh=svINnZnyDjLNpHNLsHFjhuTBT8SNQ686q063Aj8i0Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ty4dJZzC9HxoFzLPVRKYmWOXgazI6fccicLbmcMKiyQiBOyhTXcTZsWhRFXjqOp+F
	 f9+E2izSXqXYCEdOpePVaGhO9g7VufEJro6d43mwmonddNm0T7+g3hvSfff8dEGdg4
	 Bppq+RtnwtClQXFRMfG88Iwp2j/loUzaSFfk5sJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbfJCQZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390458AbfJCQZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:25:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 096AA20867;
        Thu,  3 Oct 2019 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119912;
        bh=svINnZnyDjLNpHNLsHFjhuTBT8SNQ686q063Aj8i0Wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X99fOu4qSlQM+PrsPQk/Ub540hh7K1gBtyhzeW/iM0XpD1g03hXbU1ZDgwW6K3mM8
         VWpu0rM8St/gbpPQBOlIafjynwO9dTkgEITLRAksQqTrRGzb6ZFkGPZc5PqbPsTBY+
         W7/aXrF98WmeSO6w6X3bj7rE68RlwfQLTPPFLZbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bodong Wang <bodong@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.2 027/313] net/mlx5: Add device ID of upcoming BlueField-2
Date:   Thu,  3 Oct 2019 17:50:05 +0200
Message-Id: <20191003154536.009698603@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
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
@@ -1525,6 +1525,7 @@ static const struct pci_device_id mlx5_c
 	{ PCI_VDEVICE(MELLANOX, 0x101e), MLX5_PCI_DEV_IS_VF},	/* ConnectX Family mlx5Gen Virtual Function */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
+	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */
 	{ 0, }
 };
 


