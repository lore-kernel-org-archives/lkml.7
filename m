Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D69CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC7E205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408052AbfJXLQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:16:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405717AbfJXLQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:16:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 350B1B203;
        Thu, 24 Oct 2019 11:16:53 +0000 (UTC)
Date:   Thu, 24 Oct 2019 13:16:51 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/fadump: Remove duplicate message.
Message-ID: <20191024111651.GL938@kitsune.suse.cz>
References: <20190923075406.5854-1-msuchanek@suse.de>
 <20191023175651.24833-1-msuchanek@suse.de>
 <aa26db2d-48b5-5825-81ab-12ca491a9971@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa26db2d-48b5-5825-81ab-12ca491a9971@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 04:08:08PM +0530, Hari Bathini wrote:
> 
> Michal, thanks for looking into this.
> 
> On 23/10/19 11:26 PM, Michal Suchanek wrote:
> > There is duplicate message about lack of support by firmware in
> > fadump_reserve_mem and setup_fadump. Due to different capitalization it
> > is clear that the one in setup_fadump is shown on boot. Remove the
> > duplicate that is not shown.
> 
> Actually, the message in fadump_reserve_mem() is logged. fadump_reserve_mem()
> executes first and sets fw_dump.fadump_enabled to `0`, if fadump is not supported.
> So, the other message in setup_fadump() doesn't get logged anymore with recent
> changes. The right thing to do would be to remove similar message in setup_fadump() instead.

I need to re-check with a recent kernel build. I saw the message from
setup_fadump and not the one from fadump_reserve_mem but not sure what
the platform init code looked like in the kernel I tested with.

Thanks

Michal
