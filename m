Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1191DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA2620833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDIO7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:59:33 -0400
Received: from muru.com ([72.249.23.125]:45076 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfDIO7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:59:33 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 94DF08027;
        Tue,  9 Apr 2019 14:59:47 +0000 (UTC)
Date:   Tue, 9 Apr 2019 07:59:29 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7: Add properties to enable PCIe x2 lane
 mode
Message-ID: <20190409145929.GF2839@atomide.com>
References: <20190325094525.362-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325094525.362-1-kishon@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [190325 02:46]:
> ti,syscon-lane-sel and ti,syscon-lane-conf properties specific to enable
> PCIe x2 lane mode are added here.

Applying into omap-for-v5.2/dt thanks.

Tony
