Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC174C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B173F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfD2PqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:46:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60994 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfD2PqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:46:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CED9680D;
        Mon, 29 Apr 2019 08:46:09 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F01483F5C1;
        Mon, 29 Apr 2019 08:46:07 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:46:05 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH 3/3] thermal: broadcom: Add Stingray thermal driver
Message-ID: <20190429154605.GB29909@e107155-lin>
References: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
 <1527486084-4636-4-git-send-email-srinath.mannam@broadcom.com>
 <da76e12f246c3f10bfed28d8b91a3575dc73f243.camel@infradead.org>
 <20190429152422.GC17516@e107155-lin>
 <CABe79T4MYf65QM+OHTPa_F8uG6_pd-9VLMQOHb9EPRyj2mEx1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABe79T4MYf65QM+OHTPa_F8uG6_pd-9VLMQOHb9EPRyj2mEx1A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 08:58:26PM +0530, Srinath Mannam wrote:
> Hi David,
>
> Thank you for notifying..
>
> Hi Sudeep,
>
> I will send a patch to remove ACPI support.
>

Thanks.

--
Regards,
Sudeep
