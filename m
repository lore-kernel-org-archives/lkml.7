Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC87C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135F4206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfDWJOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:14:03 -0400
Received: from ns.iliad.fr ([212.27.33.1]:57356 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWJOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:14:02 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 08976205F8;
        Tue, 23 Apr 2019 11:14:00 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E4CCF200C3;
        Tue, 23 Apr 2019 11:13:59 +0200 (CEST)
Subject: Re: linux-next: manual merge of the phy-next tree with the qcom tree
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <20190418152954.255015e1@canb.auug.org.au>
 <d194fa50-8bff-544e-eb88-128810f525f9@free.fr>
 <20190419045844.GA3322@hector.attlocal.net>
 <4e8aefdf-d0bb-9dcd-63b1-94de9d4e69d4@ti.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <264f2d81-ac96-4c57-f440-5561e72ba125@free.fr>
Date:   Tue, 23 Apr 2019 11:13:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4e8aefdf-d0bb-9dcd-63b1-94de9d4e69d4@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Apr 23 11:14:00 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 13:47, Kishon Vijay Abraham I wrote:

> On 19/04/19 10:28 AM, Andy Gross wrote:
> 
>> On Thu, Apr 18, 2019 at 09:35:44AM +0200, Marc Gonzalez wrote:
>>>
>>> It is not clear to me what I could/should have done differently to avoid
>>> the conflict?
>>
>> I dropped the patch for now.  We can deal with this later as it is trivial.
>> The best way probably would have been for Kishon to take this patch as well.
>> Then he would have fixed it up and no one else would have seen it.  But we'll
>> deal with it in a few weeks.  No biggie.
> 
> I've included "dt-bindings: phy-qcom-qmp: Tweak qcom,msm8998-qmp-ufs-phy" in
> linux-phy tree now.

Thanks Kishon,

Great news. That's one less patch to keep track of.

Regards.
