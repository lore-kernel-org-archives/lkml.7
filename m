Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CABFC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C9B2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfE0Iov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:44:51 -0400
Received: from torres.zugschlus.de ([85.214.131.164]:36766 "EHLO
        torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfE0Iov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:44:51 -0400
Received: from mh by torres.zugschlus.de with local (Exim 4.92)
        (envelope-from <mh+linux-kernel@zugschlus.de>)
        id 1hVBFR-0002yM-Ee; Mon, 27 May 2019 10:44:49 +0200
Date:   Mon, 27 May 2019 10:44:49 +0200
From:   Marc Haber <mh+linux-kernel@zugschlus.de>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in KVM guest segfaults when hosts runs Linux 5.1
Message-ID: <20190527084449.GC3249@torres.zugschlus.de>
References: <20190512115302.GM3835@torres.zugschlus.de>
 <20190513141034.GA13337@flask>
 <20190514065128.GU3835@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190514065128.GU3835@torres.zugschlus.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 08:51:28AM +0200, Marc Haber wrote:
> On Mon, May 13, 2019 at 04:10:35PM +0200, Radim Krčmář wrote:
> > 2019-05-12 13:53+0200, Marc Haber:
> > > since updating my home desktop machine to kernel 5.1.1, KVM guests
> > > started on that machine segfault after booting:
> > [...]
> > > Any idea short of bisecting?
> > 
> > It has also been spotted by Borislav and the fix [1] should land in the
> > next kernel update, thanks for the report.
> > 1: https://patchwork.kernel.org/patch/10936271/
> 
> I can confirm that this patch fixes the segfaults for me.

And it is not yet in Linux 5.1.5.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
