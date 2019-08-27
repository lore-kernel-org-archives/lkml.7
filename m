Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC31C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420B52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893141;
	bh=4P/gAouZIdFMsBneTHs1ZtIaXiQfH/mCP8xF6/oNNHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QWEf2cCk32Y9fwCe2LAyzSPhn+klR4SF3+t3G4wJwkyv3t5liMGdn7ZJd5MZ4PdMm
	 l1THuHz5f4PlNZB5Dz5GiBmTP4nyWx68Hd9qoT20a5KTbysY6ywupKQIcJyaUKOz4Q
	 O7arY0bytbXCuyFpXO8rFGM+C0jLMhUgrHjotUf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfH0IFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732838AbfH0IFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:05:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E6E2173E;
        Tue, 27 Aug 2019 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893137;
        bh=4P/gAouZIdFMsBneTHs1ZtIaXiQfH/mCP8xF6/oNNHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p38NCP7o/QXJoCVlVz9kuxPIx8ahvmJkwEhSFM0dnqTPCZfCIcgAfshYqr6l7C5o+
         0AejRPF9ROeVj3Xm7RK07w0AlFEPZLb0vmzEvNQs2ppuPNLn5ko+nrSp7TBBcLQh2V
         4vB34v7MoZ6Fi8lajzFgV9ksACAEbQlXvQgW3MnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 106/162] dt-bindings: riscv: fix the schema compatible string for the HiFive Unleashed board
Date:   Tue, 27 Aug 2019 09:50:34 +0200
Message-Id: <20190827072742.007693245@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b390e0bfd2996f1215231395f4e25a4c011eeaf9 ]

The YAML binding document for SiFive boards has an incorrect
compatible string for the HiFive Unleashed board.  Change it to match
the name of the board on the SiFive web site:

   https://www.sifive.com/boards/hifive-unleashed

which also matches the contents of the board DT data file:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts#n13

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/riscv/sifive.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive.yaml b/Documentation/devicetree/bindings/riscv/sifive.yaml
index 9d17dc2f3f843..3ab532713dc12 100644
--- a/Documentation/devicetree/bindings/riscv/sifive.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive.yaml
@@ -19,7 +19,7 @@ properties:
   compatible:
     items:
       - enum:
-          - sifive,freedom-unleashed-a00
+          - sifive,hifive-unleashed-a00
       - const: sifive,fu540-c000
       - const: sifive,fu540
 ...
-- 
2.20.1



