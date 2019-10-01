Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B20C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B4E215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=deutnet.info header.i=@deutnet.info header.b="gPx1zIf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfJATIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:08:23 -0400
Received: from srv1.deutnet.info ([116.203.153.70]:55156 "EHLO
        srv1.deutnet.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJATIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=Message-ID:Subject:Cc:To:From:Date:in-reply-to;
         bh=pCXhZADSlYDWxpTdZrOF60LS2Vb4x3ektC2jg3S3tQs=; b=gPx1zIf1WK0P6vyHJJedr1UQi
        +mSm8EFwXjLI0JMh3dkRl/6ikjForE99vw4eRxC9vP03ULMU5YvemFIu6QaFxyf9uf4BsnorsXeAS
        OHsuCbxptMdd5G4ppB6wTqLzrsbUjLv6YjfHZJuzOYHLqjPg3+RY86pvT5rHjWComBdwrCi8XVAI3
        q58mrYdIo5chjUkursaPZarQ58JRr11JoE31wTJjzjF/5vZ0pjUmXZK1b9pOo4iTgPkj6fqtcdU8Q
        gll//GxUpEtMqBZ/RWXIkCNx3Ae27Rg1ZVc/sKKaMP2Jc3kVuDZH8TnnDPO7F+3xJ16K/ELlB1kpe
        arsuI3etA==;
Received: from [2001:bc8:3dc9::1] (helo=localhost)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1iFNVT-0000oC-OM; Tue, 01 Oct 2019 21:08:19 +0200
Received: from agriveaux by localhost with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1iFNVT-00BgLU-8n; Tue, 01 Oct 2019 21:08:19 +0200
Date:   Tue, 1 Oct 2019 21:08:19 +0200
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, agriveaux@deutnet.info
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] MIPS: CI20: DTS: Add nodes to Creator CI20 board
Message-ID: <cover.1569955865.git.agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attemping to make my CI20 more usefull than a paperweight, I add nodes to Devicetree, at this time:

- Add I2C node PMU and RTC. 
- The IW8103 need some work to stay alive because power seem to turn off.
- The leds patch lack of correct option in ci20_defconfig.
- The Cpu patch isn't usefull without SMP support of jz4780.

Alexandre GRIVEAUX (5):
  MIPS: JZ4780: DTS: Add I2C nodes
  MIPS: CI20: DTS: Add I2C nodes
  MIPS: CI20: DTS: Add IW8103 Wifi + bluetooth
  MIPS: CI20: DTS: Add Leds
  MIPS: JZ4780: DTS: Add CPU nodes

  v2 adding previous sended patch: JZ4780: DTS: Add I2C nodes

 arch/mips/boot/dts/ingenic/ci20.dts    | 214 +++++++++++++++++++++++++
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 103 ++++++++++++
 2 files changed, 317 insertions(+)


base-commit: 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c
-- 
2.20.1

