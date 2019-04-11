Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1EEC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163E82133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDKHRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:17:12 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33889 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKHRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:17:11 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A0D7EFF80C;
        Thu, 11 Apr 2019 07:17:05 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] arm64, mm: Move generic mmap layout functions to
 mm
To:     Kees Cook <keescook@chromium.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20190404055128.24330-1-alex@ghiti.fr>
 <20190404055128.24330-3-alex@ghiti.fr> <20190410065908.GC2942@infradead.org>
 <8d482fd0-b926-6d11-0554-a0f9001d19aa@ghiti.fr>
 <CAGXu5jKt8f7=DKrvcPg-NUJGbc-vanMNojfDsEiBt3vP05G4oQ@mail.gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <4c498b2b-e916-3389-209f-aa4cc7b523ff@ghiti.fr>
Date:   Thu, 11 Apr 2019 09:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKt8f7=DKrvcPg-NUJGbc-vanMNojfDsEiBt3vP05G4oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 08:27 PM, Kees Cook wrote:
> On Wed, Apr 10, 2019 at 12:33 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> On 04/10/2019 08:59 AM, Christoph Hellwig wrote:
>>> On Thu, Apr 04, 2019 at 01:51:25AM -0400, Alexandre Ghiti wrote:
>>>> - fix the case where stack randomization should not be taken into
>>>>     account.
>>> Hmm.  This sounds a bit vague.  It might be better if something
>>> considered a fix is split out to a separate patch with a good
>>> description.
>> Ok, I will move this fix in another patch.
> Yeah, I think it'd be best to break this into a few (likely small) patches:
> - update the compat case in the arm64 code
> - fix the "not randomized" case
> - move the code to mm/ (line-for-line identical for easy review)
>
> That'll make it much easier to review (at least for me).
>
> Thanks!
>

Sorry about that, I'm working on it.

Thanks,

Alex
