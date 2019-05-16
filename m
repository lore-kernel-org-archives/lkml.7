Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95342C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAFF216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfEPS3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:29:53 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:54116 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:29:53 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-51-100-nat.elisa-mobile.fi [85.76.51.100])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 25497300CD;
        Thu, 16 May 2019 21:29:50 +0300 (EEST)
Date:   Thu, 16 May 2019 21:29:49 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     sudeep.holla@arm.com, julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kernel/panic: Use SYSTEM_RESET2 command for warm reset
Message-ID: <20190516182949.GD10985@darkstar.musicnaut.iki.fi>
References: <ce0b66f5d00e760f87ddeeacbc40b956@codeaurora.org>
 <1557366432-352469-1-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557366432-352469-1-git-send-email-psodagud@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 08, 2019 at 06:47:12PM -0700, Prasad Sodagudi wrote:
> Some platforms may need warm reboot support when kernel crashed
> for post mortem analysis instead of cold reboot. So use config
> CONFIG_WARM_REBOOT_ON_PANIC and SYSTEM_RESET2 psci command
> support for warm reset.

Please see commit b287a25a7148 - you can now use kernel command
line option reboot=panic_warm to get this.

A.
