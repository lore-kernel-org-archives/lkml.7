Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686EEC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F470208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHKJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 05:05:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38924 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfHKJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 05:05:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so48012076pgi.6;
        Sun, 11 Aug 2019 02:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IcaO688fqJ9Hhcivif+YH1kMxvlYAd9l9NqrayDjxq0=;
        b=OWkY+cvsQHo6nG/1/wUs0s/HCs2ucdS4RkIyDu1RUYKmhqJImTogg521JDtDceLcSK
         efEg40j+wjaEpAO8/cf2+HD0biWxbw+me4W1zGScnxjkz32JtQLFnbwh0SONfdIh8k8o
         +XlvwAmivn9m/H9JZ04QixDJicFSosF38JqfmS3+U/GEHWvKTBkL+kV+MNMojfuh40W/
         5GpDtZemDaI8NowsGz0wuc5F2ZnXrkIT1bmv3Zd71V+Q4/UGqdzBenUtugvDWJEV/z3d
         9KVX1I+85xmH2KevQh3baEAHJRWPx3OLFf5LGpW3yi0zw5Si1hHI4Ayl56QZR+ehV3sq
         kZvw==
X-Gm-Message-State: APjAAAWeUpHn5oY4P67LhHXpn2OtamrnJUf3+4UjpKY/Qod1cFiTf/r6
        UibbAdnyqFFb4Uaxh234fEs=
X-Google-Smtp-Source: APXvYqx2blkLw/V4FEJpl8ZqPLTs9eoghw79426vNrE77wukLP1oTnruHW4TTYpJjIaWDZC5dITeDA==
X-Received: by 2002:a62:e801:: with SMTP id c1mr30719946pfi.41.1565514315923;
        Sun, 11 Aug 2019 02:05:15 -0700 (PDT)
Received: from archbox.localdomain ([203.88.145.156])
        by smtp.gmail.com with ESMTPSA id q63sm134447761pfb.81.2019.08.11.02.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Aug 2019 02:05:15 -0700 (PDT)
From:   Bhushan Shah <bshah@kde.org>
To:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhushan Shah <bshah@kde.org>
Subject: [PATCH 0/2] Enable the I2C nodes for Allwinner H6 CPU
Date:   Sun, 11 Aug 2019 14:35:01 +0530
Message-Id: <20190811090503.32396-1-bshah@kde.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds device-tree nodes for i2c nodes in the H6 dtsi,
and enables it for the Pine H64.

Bhushan Shah (2):
  arm64: allwinner: h6: add I2C nodes
  arm64: allwinner: h6: enable i2c0 in PineH64

 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  4 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 54 +++++++++++++++++++
 2 files changed, 58 insertions(+)

-- 
2.17.1

