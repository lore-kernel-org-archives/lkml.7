Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA818C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8B521928
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfI0M7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:59:17 -0400
Received: from foss.arm.com ([217.140.110.172]:51844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0M7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:59:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49A751000;
        Fri, 27 Sep 2019 05:59:16 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10C053F67D;
        Fri, 27 Sep 2019 05:59:14 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:59:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: stm32: Enable high resolution timer
Message-ID: <20190927125912.GB8704@bogus>
References: <20190927084819.645-1-benjamin.gaignard@st.com>
 <da48ce9633441cd0186518fa7ce1d528@www.loen.fr>
 <341949c8-7864-5d65-2797-988022724a4c@st.com>
 <ff11797da8f049b354797689754fde52@www.loen.fr>
 <69af57d1-13a9-9e35-78f2-4a0d17bdaf6d@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69af57d1-13a9-9e35-78f2-4a0d17bdaf6d@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 12:44:55PM +0000, Benjamin GAIGNARD wrote:

[...]
>
> Even in low-power modes this timer is always powered and clocked so it
> is working fine.
>

Is that tested ? I see only cpu_{on,off} available on this platform with
PSCI v0.1. Did you add cpu_suspend, idle-states and then gave it a spin ?
Or do you have some other idle driver with which this is tested ?

Also I don't understand how "always-on" is linked to hrtimer. Always on
timers are just selected to be broadcast timer without sacrificing(simply
keeping) a cpu to be always active for broadcast purposes.

--
Regards,
Sudeep
