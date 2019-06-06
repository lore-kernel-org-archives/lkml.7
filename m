Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95764C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE3E20673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfFFOUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:20:55 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfFFOUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:20:55 -0400
Received: from [192.168.1.110] ([77.9.2.22]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M91Tq-1hWAED47fi-006Aqa; Thu, 06 Jun 2019 16:20:48 +0200
Subject: Re: libata: sysctl knob for enabling tpm/opal at runtime
To:     Christoph Hellwig <hch@infradead.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        linux-ide@vger.kernel.org
References: <1559734587-32596-1-git-send-email-info@metux.net>
 <20190605192320.GA16831@infradead.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <3720d2a4-c8e8-0024-bc39-2aed5c4bf0a3@metux.net>
Date:   Thu, 6 Jun 2019 16:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190605192320.GA16831@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/GS942zi5O5i4vgVfWA015f/miYS7gLEV1AIVPzcAU0rhaL3Gvy
 3aaSJnmYcCRviX1XlstBl/SpOrplHBMcTD+Xx4XmkVRyVPj5zLdQtFB9r3b4xtknjjUhvgU
 vyfjgtWyRbgzyMJIiYzxXkX2+7ucABLPGDI1t0wlFxUCb2nneTkM61L84cZOG8W6lGabz9e
 RkTbmz/AueP+cMvyLA2ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8bLMwidkVXw=:4ARllqipmzLaR77mg2XFIF
 6m1TxPNtdM3N+Ot6a2TUfLcF4K2v4i7u+wrcAOSuHanbQTOIU88Oo6bVDIeEuP+N97oxtMLp2
 hXhncvNPGVVOPSrPMfuMBWOOxOd2GPLDjR9Ww8uC1PA23pxDH7dopA25QvWDPl8NWCQGYnpjy
 HwlIQFV3t+kZFjR/wip/Q4Gk/eMeiGrdvfXs8bjaV9SLBgB8xUw9u2xg+x5H18ma3nEI/57+u
 sk13yt4t4cR0zY0C0Acv6hOcsgd3zN4q3uG/lxlbqBjqqzL131unLiqK6h5gyGZdZAqk99CJk
 WhhXV7y7hvJmfj2t9W+J6kp7UE86l1FDx2tZWsk0uHxGE/RQ3sg0aB88xTHPmn2Mn70Sak0G7
 u1AlFoPqWPiMEXJ2JDCg10+/2gXrOif0Fx2cSQyw2ERH+1sckJTnOzWXriOliN/GEpsjieMvs
 aeNglV8DYMbj8BZQQTJ+l2emRf9ItgzPRwrLlncRR81TBDrUgwrhYcPlgnhToZ9ciSZBv8X6A
 qklgqqNtTHhczzYWGh86widWA1iAv9ZSGhkF4R8RW5/bGATwg6imBxFfi3kInEzWBTfjUi3cn
 fOmppP3DqPv3n14iwcgVZGKx38XKejzovXKHgjt5G1RaP24sMdGA2J+gxp9pOuU/z8Mio3dmk
 bX6uU+O1z/+3+yibVPJiQTwuF/7Ij2Dn85naQ/71zYIzD+y+aidFmcSyYviP1VV4IsRU5r/9E
 fqkxQOXhwvLrdBFNZQ8ZDa8LcDzLATog2ol9+6mhtsyzGLJV6RYPAZjQwVI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.19 21:23, Christoph Hellwig wrote:
> On Wed, Jun 05, 2019 at 01:36:25PM +0200, Enrico Weigelt, metux IT consult wrote:
>> Hello folks,
>>
>>
>> here's a patchset that allows enabling libata's tpm features (opal)
>> at runtime. Until now we need to boot with special kernel parameter,
>> in order to use OPAL - this patch also adds a sysctl knob for that.
> 
> Or you can use the block/sed-opal.c code which doesn't require the
> tweak, and really is the proper way forward to use OPAL.

You're referring to the OPAL ioctl()s ?

hmm, it seems that sed-util doesn't use them at all, but directly
sends raw ata commands.

Shall I use a different userland tool ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
