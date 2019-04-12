Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B449C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426CE21872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfDLP5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:57:37 -0400
Received: from muru.com ([72.249.23.125]:45650 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfDLP5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:57:36 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 55A9D80F3;
        Fri, 12 Apr 2019 15:57:51 +0000 (UTC)
Date:   Fri, 12 Apr 2019 08:57:32 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Christina Quast <cquast@hanoverdisplays.com>
Cc:     Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] ARM: dts: am335x: Replace numeric pinmux address
 w. macro for more boards
Message-ID: <20190412155732.GY2839@atomide.com>
References: <20190409160346.25599-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409160346.25599-1-cquast@hanoverdisplays.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christina Quast <cquast@hanoverdisplays.com> [190409 09:04]:
> Depends on the following patch set:
> [PATCH v2 0/6] ARM: dts: am335x: Replace numeric pinmux address with macro defines
> 
> Replace the numeric pinmux address with the macro defines for an additional 15 boards.

Thanks applying these into omap-for-v5.2/dt-am3.

Regards,

Tony
