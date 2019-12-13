Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C612C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A1E2465E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfLMKIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:08:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:32806 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLMKIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:08:35 -0500
Received: from wf0651.dip.tu-dresden.de ([141.76.182.139] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ifhrt-000106-VL; Fri, 13 Dec 2019 11:08:17 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     tom@radxa.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Akash Gajjar <akash@openedev.com>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        matwey.kornilov@gmail.com
Subject: Re: [PATCH] arm64: dts: rockchip: Add regulators for PCIe for Radxa Rock Pi 4 board
Date:   Fri, 13 Dec 2019 11:08:17 +0100
Message-ID: <2621713.C5CYpBeeQa@phil>
In-Reply-To: <20191120161302.5157-1-matwey@sai.msu.ru>
References: <CAFjve-AT6c-yweF0mOPea-caG3n43nZzVPcwef-qp+n35JN9ig@mail.gmail.com> <20191120161302.5157-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. November 2019, 17:12:54 CET schrieb Matwey V. Kornilov:
> Add 0.9V and 1.8V voltage regulators for Radxa Rock Pi 4 board PCIe.
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>

applied for 5.6

Thanks
Heiko


