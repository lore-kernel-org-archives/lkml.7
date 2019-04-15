Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98BDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEAA2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfDOP14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:27:56 -0400
Received: from muru.com ([72.249.23.125]:46136 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfDOP1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:27:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E3C8D808C;
        Mon, 15 Apr 2019 15:28:08 +0000 (UTC)
Date:   Mon, 15 Apr 2019 08:27:50 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Christina Quast <cquast@hanoverdisplays.com>
Cc:     Benoit Cousson <bcousson@baylibre.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] ARM: dts: am335x: Replace numeric pinmux address
 w. macro for remaining boards
Message-ID: <20190415152750.GB2839@atomide.com>
References: <20190412162627.24518-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412162627.24518-1-cquast@hanoverdisplays.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christina Quast <cquast@hanoverdisplays.com> [190412 09:27]:
> Last patch set of the patch series for the remaining 17 boards.

Thanks applying into omap-for-v5.2/dt-am3.

Regards,

Tony
