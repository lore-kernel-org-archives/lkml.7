Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B09C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9135E20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfDAOcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:32:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35810 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfDAOcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:32:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FC5CA78;
        Mon,  1 Apr 2019 07:32:46 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D98753F690;
        Mon,  1 Apr 2019 07:32:43 -0700 (PDT)
Date:   Mon, 1 Apr 2019 15:32:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Muchun Song <smuchun@gmail.com>
Cc:     will.deacon@arm.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>, logang@deltatee.com,
        robin.murphy@arm.com, ghackmann@android.com, hannes@cmpxchg.org,
        stefan@agner.ch, david@redhat.com,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: mm: fix max_mapnr is assigned the wrong value
Message-ID: <20190401143241.GH14874@arrakis.emea.arm.com>
References: <20190330131346.40289-1-smuchun@gmail.com>
 <20190401104432.GB14874@arrakis.emea.arm.com>
 <CAPSr9jHmx8unVN3rsQzGSSc4hYL2wafw20D8QKf8NG65dX7ErQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSr9jHmx8unVN3rsQzGSSc4hYL2wafw20D8QKf8NG65dX7ErQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:21:58PM +0800, Muchun Song wrote:
> Thanks for your reply.  In fact, I didn't hit any problem.  I just read the code
> and found the problem. I see max_mapnr is to only be used in the
> generic pfn_valid().
> As you said, we do not use it on arm64.  So in a sense, the patch is
> meaningless.
> 
> But I think since it is a problem, why not fix it (Even if max_mapnr
> is not be used)?
> What is your opinion?

I'm ok with fixing, only that it's not urgent. Will can pick it up for
the 5.2 merging window.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
