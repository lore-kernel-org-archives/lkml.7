Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56455C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2104120658
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RRLDUyGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKURvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:51:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:58745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKURvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574358696;
        bh=hbF2nIkaDtX1kFzi+s4F0AlQa64mmkmSl8UM8AFU8gg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RRLDUyGeqsrqpbZfxi6TLHWOOYsTB+Ufc9ViGLsKe3G0P1u3sUgXMXXE3F7KVTesF
         qvKNpChBpwPsM5gD5FheLMBrN9yj49QLSLaLrv8qfANUDzN9z+TjG9ZfeexoKa6I8H
         oHG572nmPBrDVZKcsQjgN6by9JioxzNgckafE2FQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.176] ([37.4.249.139]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1iS5KJ09Sh-006McN; Thu, 21
 Nov 2019 18:51:36 +0100
Subject: Re: BCM2835 maintainership
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <68580738-4ecf-3bb7-5720-6e5b6dafcfeb@gmx.net>
 <e225fdf0-1044-cc3e-89f8-a569596e8bce@gmail.com>
 <52c0e259-9130-fa56-a036-dec95d4bd7d4@i2se.com>
 <51d2c5e6-7cd5-02a1-77c9-c96b27a04242@gmail.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <902d2270-8081-b21d-e572-627f470beda7@gmx.net>
Date:   Thu, 21 Nov 2019 18:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <51d2c5e6-7cd5-02a1-77c9-c96b27a04242@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:6wdE1ZagdlAq+hhK5gvxvd7T7ZkVeawUOrOIzJj+KnwWF8zf5Gx
 oF2m6slvhjCU2vo0gCTHXACSYFuRtmeMK6QHtaPLKtdm5KAmZ7AOfPHyn8kdv2UaIkMpR35
 eWBKXrnCgopEocxWC1mmOR9ifUCNlC1lKK52Lz2pKF22y3yEOZbedQl52Pz9ry8WqHdk8HR
 v9/uJx1nmo0LEBo2aH2tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dnz6/iHSuy4=:Tpkfmc8y5hbzZnDhxKoS0v
 p2zSDRhC2acGTSMzahsru+B4liyPvK+Q0ZZuMNR+gZ7Qhdpl9Foa0YxK2F+1LtSbNIbFvKEgX
 Fp9jujyuDdpo3ExOpNDRljm9hsFPHYWlgkcCSr0qyhnwQ8k9jXApIzb0VdHGAeoZknAqflFTt
 Zm4FLoCQmcyncWwvnuCfmBTIO2WExCHpS2HAkyzQOn6Iff+IPqIfBk19eAzWGZb36Bs4RWNX4
 biQSiZBm27RWcMQF5HfKrhjX4+oxdVOcslubfTKEI0MM46GV9WMOgvlVaaQ4UnQf+mh/GueMG
 W7syxLljFXe3aBsqIAlfaO5nnGdFJk1awukBUbqR/VViMgPjDMyPQzNZbWCBfF4TsiWqPmm3h
 a8OpG0hlBU2CbiLaamF206eMzw3SQeu+aT+ka4509YfcnIAYSTr79MfnsE99cX5bt02prDaxy
 DZPLgQINQVtk5ndO/xjdxlOv1+/5DjQkMAvaWoAp2g5G7brRAFLnj1ySSs6JDrrW2jSLvO2oz
 cDBUz9M3ZPipKWhXJNHdqHQsNp5kcf/i0e5i8r+amvhl2S2rbke+wnpbhMMnOKaoKbDBGKJvf
 6GbxEhzyQ2lKFYYEIPKmQBBn+V1PzGnhkwwRzbkTGW3UoFigfiQnD9/e6y6wfP9W02H7tXSqp
 nqhKnUuNg0sTDrw0KUErISU7yLCvlTvhTG2BcGJVMaxOBELbnSKIDrtBCtRq3eDbm+Ccko8UI
 1i453yYBGAq+x7RrcyEu6CtQEm+S3tXjVbnR/3SZNHDrB9/b1E9639/4QvKt9zC1fzw9/SN80
 pO/KbhgzUUqf3BjyXRv8YXRy5X3zVzGaxpnBWK9zFxyGqGMo7+9Mo1WvZnuNGBmpX1XGL14i1
 5uJZSVAVDSzDy+4SR8K7RVhl5y5ABiAtUiior+9KqGZQ4paJ0oENWSszdmmpCM6JnBOwI2Eo5
 k29lh4LEgo+DsQrYmyal+XoJE7Ta0t67OtYXrTTqd/hCfmxYH/BDlv16n7v2fMF2ZhOdR3Zmz
 j6ALYWq+yS8kR+zUUPa8L2RwEiEu0VML0uAeiG4AZhSRp7zanGNA0MCVPrcDDscNacYFRsLgv
 wm+8MThIR6mf6nYXrkag+6cDU38vVn1M+u25ubmAf9nZ+A2qjvW1CitKqKj2cY+OLRwvcYlxU
 ckQFt8Cte1NQFGNCJifElijd6R7fP42yQugkoS/PQyQ/vNJfVVNj7eOcr2MVU3TN5ldz0EABy
 178YymD4rdw7N3vxxYul3JJ0HPcrd0Zqgv0rRiXynklDFvRYA1c8UWEDCFAc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Am 21.11.19 um 18:42 schrieb Florian Fainelli:
> On 11/21/19 1:56 AM, Stefan Wahren wrote:
>> Am 20.11.19 um 22:54 schrieb Florian Fainelli:
>>> On 11/20/19 3:38 AM, Stefan Wahren wrote:
>>>> Hello,
>>>>
>>>> i need to announce that i step back as BCM2835 maintainer with the end
>>>> of this year. Maintainership was a fun ride, but at the end i noticed
>>>> that it needed more time for doing it properly than my available spare time.
>>>>
>>>> Nicolas Saenz Julienne is pleased be my successor and i wish him all the
>>>> best on his way.
>>>>
>>>> Finally i want to thank all the countless contributors and maintainers
>>>> for helping to integrate the Raspberry Pi into the mainline Kernel.
>>> Thanks Stefan, it has been great working with you on BCM2835
>>> maintenance. Do you mind making this statement official with a
>>> MAINTAINERS file update?
>> Sure, but first we should define the future BCM2835 git repo. I like to
>> hear Eric's opinion about that, since he didn't step back.
> How about we move out of github.com/Broadcom/stblinux as well as Eric's
> tree and get a group maintained repository on kernel.org, something like
> kernel/git/broadcom/linux.git?
>
> Then we can continue the existing processe whereby BCM2835 gets pulled
> into other Broadcom SoC pull requests.
>
> How does that sound?
this sounds like a good idea. In case the others agree too, can you take
care of it?
