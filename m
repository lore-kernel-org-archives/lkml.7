Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53207C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA07218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfCVHCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:02:12 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:58131 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCVHCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:02:12 -0400
Subject: Re: Radeon HD 7450 brightness oversaturated
To:     Alex Deucher <alexdeucher@gmail.com>, Meelis Roos <mroos@linux.ee>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <6f3801ea-476f-6715-db9b-0eb188c5711d@linux.ee>
 <CADnq5_O-sFxVsbxouJBRYi=H+RCmc0==jB7XVTifvWm-+EQLnQ@mail.gmail.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <e61ee046-92fc-4e3d-02fb-c53d5699e41d@linux.ee>
Date:   Fri, 22 Mar 2019 09:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_O-sFxVsbxouJBRYi=H+RCmc0==jB7XVTifvWm-+EQLnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I decided to put a discrete graphics card into a PC and found a fitting Radeon HD 7450.
>> It works, but there is strange whiteness like the brightness is oversaturated and
>> light places turn into other colors:
>> * on fbcon, right after radeondrmfb initializes
>> * in X after powersave
>>
>> The colors return to normal after a VT switch or two.
>>
>> Screenshot of one such washed view is at http://kodu.ut.ee/~mroos/radeon_washed.jpg
>>
>> Kernels are 5.0 and 5.1-rc1.
> 
> Is it just kernels 5.0 and 5.1?  There haven't really been any display
> related changes to radeon in ages.  Possibly a duplicate of:
> https://bugzilla.kernel.org/show_bug.cgi?id=198123

No, I just put the card in and tested with only the current kernels I had.
I can get some older kernel and test with that if that is of any help.

-- 
Meelis Roos <mroos@linux.ee>
