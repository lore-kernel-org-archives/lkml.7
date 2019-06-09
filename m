Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EAC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860132083D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UuoEUzsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfFILAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:00:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:45883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbfFILAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560078046;
        bh=5KM3c4fDB8CweaH+p6a3cb0q/2aj01VmFRK+2KetZQc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UuoEUzsuD1fpPsz1WkYRUYlyiuLDXOQ8jzT8EuRU68BJR+cRoKzO8eY2UTaSWZgUP
         44BPKBcyqTDFy9MpENxWQKCzcs7H34EKLOlvK77kCnxp8s74JWL8fh82yp2nBzRRQF
         0AERvdYgmnad6XuIdyi0KTt6UDhTDewKCYkRH+H0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([109.190.112.71]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0M5Z5A-1gcLkz3uXI-00xXI6; Sun, 09 Jun 2019 13:00:46 +0200
From:   =?UTF-8?q?Harold=20Andr=C3=A9?= <harold.andre@gmx.fr>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Harold=20Andr=C3=A9?= <harold.andre@gmx.fr>
Subject: [PATCH] Staging: ralink-gdma: fixed a brace coding style issue
Date:   Sun,  9 Jun 2019 12:58:46 +0200
Message-Id: <20190609105846.27225-1-harold.andre@gmx.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ulm5W9TTIpjxLNJFVhxZb0dxFMToHBP20liPUIJ/8FS2W+be7HY
 pEtq4jcLckGkMvGYNfhqgHd6OdeWrgN805NtYEpvSHI2da6aAnUW+1T8ZkrTDhm6Mkk4Tkb
 RG6IP/RgpH6VjQnF72prxz85ee0r61Sy8KtDSSJ6n4GU1J0Iriy2MMYvtEzzYy1WhU8bHg3
 BMGFYVGAfXORHV8WZx2tA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9uDJ8t9ggtM=:GFqTezi8/xt8nRMScxrIYF
 ynrOMdmjPbzIlcvJcf3unsPmIXEd8r5V3PniJDHPx4F+NsG2oyTIQAey7VY6blHS5dXhNMWIa
 3r4vv1Q9cBzPTLkPtrmHgS4+gnZLe+Pa9xho927jNHVk4zKYOEfY9XZef7WVuLjZCesx0SuCO
 cKBvIRz5NDY5PF3PwbuhvAXO88Me0SUS+9SvjS6VYR80/R4ADzfkxS4sTWxRhNu2YPqoXFxfH
 CC1CUqJwbGRj8FZI5gL9gje4LxUHYL5poVhB78jsyuMBMrkfok3zW9BwQya9xe2ueg5DmM+d+
 lE4PkXT0R7yzPJjjoSGMpvuJg0gl+lJzpMRbagKovBDWLSa5ucOrOYJzTLcZy4wAmT9btbJvE
 KYknzq7E5jb8wbPWwjWCa1J1RbGP/Hg/u2D916D5kpfaJxOQGF01UxTkzUEJ60ALQP9i+6QZC
 OhyGUUojwVUFQasO3HacslBO+plz1XtZOWodkdtpwyNxA3UmaDEkB9x/65Q1oWozjZt1viWAT
 dq2ACJ7mE/+S17N9LRNA5dwipf7wV9OmbqeC4+5LugOrU4QMjC1g4Zhk48oIW903f0/ovfJFa
 TIQ6S6GtlZo4BwHMG3LBDdddfg0X6axqqMxOgE7ePFBO0HXrLGY7P915VYhSkNOKpzAUJ0GkU
 TeoJ4aasYIDK5CwJCz6cu7G/UFQUzv6LQqyxLbwpFajY28Mj9ty83Lbm4mXerHm5smMsle+lz
 9M0I3/DpNlgiffMu83c4Wr7o2P+DaWT4k0BXzr2T2woD/bjG+yapI49eG2qWaSkW7LCF/iEX/
 /NzsGuTlyZWWv4G6ZGQi3JIIcta82eQy/0Fd7ja/bxsLrxKTcU7gKeNDWvjnWxrkMbZtOIU4U
 2VTfV8HFaQAFiKROv09BVNU3rvextjv8zQpnaB7e4tbSH6dWSscB4BayN7G4X/+CM3cjBVFpy
 b8nOps5U7k3/AO9DYKxHFSZdcarkHQC6xSV5f+ZXO1mU8ipOyzMekNc63IqSLF0onI9GZDH/R
 Vg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Harold Andr=C3=A9 <harold.andre@gmx.fr>
=2D--
 drivers/staging/ralink-gdma/ralink-gdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/r=
alink-gdma/ralink-gdma.c
index de3e357b2640..5854551d0a52 100644
=2D-- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -814,9 +814,8 @@ static int gdma_dma_probe(struct platform_device *pdev=
)
 	dma_dev =3D devm_kzalloc(&pdev->dev,
 			       struct_size(dma_dev, chan, data->chancnt),
 			       GFP_KERNEL);
-	if (!dma_dev) {
+	if (!dma_dev)
 		return -EINVAL;
-	}
 	dma_dev->data =3D data;

 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
=2D-
2.20.1

