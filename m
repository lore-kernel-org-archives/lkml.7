Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B1FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584BE2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kS6gbv1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfENSdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:33:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:34043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfENSdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557858784;
        bh=UmmAvvJcx8I5MMGXOj9REi0B1R3jq6Ia0rLijAgsU0U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kS6gbv1SZ2XMU9peN3uYmv9WbMJO+ytypmiPtxGaue8HXVOzgAY5lwFMh5TpreA80
         0tj6gxW+kCar/ffJoxXfN0V8k2e4lCHbpNffvoguvKDFLdtzfgljNKicf3vikAXElM
         Jxz4thTAQJBQAM03W0Cq1N7AASE4pfNS+DMTLZ8w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([77.6.146.38]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuOYx-1gj8fI3PyJ-011lSy; Tue, 14
 May 2019 20:33:03 +0200
Subject: Re:
 https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html gives 404
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <d200d191-258e-ba3f-1c7f-9f2e7fee5b36@gmx.de>
 <20190514121436.7770a83a@lwn.net>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <087cd550-3b07-5e96-c91a-6c6f2d8dc251@gmx.de>
Date:   Tue, 14 May 2019 20:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514121436.7770a83a@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B2yO+2IVvZ4PRr/uPHpdbcS4iqZxm7pZMkd9cAQMRVO1VHLCYCO
 IVGePwANfsFwrN09Lbd96GeUk2aQ7fICZSP4gWYMLHhyF914NvNb26JHWKcD+UN7QspUbz3
 IiKuyIMYbxMXu5P2uRjbtLz7HzIvlbOThjlEUmL+K6+8eFwwGKp4NzfXFkKGCGDzAcYMmka
 X4Fl0yO2WzJSoJ2H401ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:44g8DuR7jhU=:iJZhdFB+Bg1PLc9kDT9suF
 8NK/gLga6w8jlrvnmL7gYEQt25iZuB34xEKuZ227jXhThI7I07a7DHytm+7UYFzouDzj99x66
 7LKh+zFlmoHRnyjxlGwWA3u6JIad8Y79I7Vl7TGb0Lev4SIwu4YjnQwSxT82Co8cXvPKib6CJ
 i+91XjIp/URAq11fnhji22N5A2QlrAP79vsrIpdJls0qYPMuMxajlkK+3Mw5+ocs0SJoYeZV7
 7336gHuBZHNI1XrwYAncqlASuou5W6divifEiIhqm5oicWcVvCwTQjy7MNPBx2B6ZVO5kic3x
 ZILY5/GO2/iuysxgbC3CUrzvUckhyM5/YKhPEIItjgRWhXj8LjiSMUkbZofjfZimpX9vzafy/
 uDjxNJhcnFHkixJ/1UG/iaOjzNiiGvZm6s/dIFfNd7bWbSA6TxbDiegDXB6Yiyyxjljun/89Q
 KkWq0I0CPAzvalpSA1MiaAyLH3e1TlcUUER4aNjMOUn8dbKLHnBBgXSqBVwanY9dsHnrlzGv0
 jMSanBWnEPaMrke5zlLpl64EvQuVb42slcYFVc0pmkoQ+lSKTlfJ4m6TZ+wdclVZ4ePllkEwp
 wz018i0h3Z67CywXs5tT+VK4tq4bMMjXA03PCfAmUwaLJ07kHBhsbnxFsBp+gUSZbrGP6XHYR
 011Na7BkpzrEjoq+I/37MR/0GTB3rhk2Yk9CY4Eprhlb6jhQJcdJe6IsBsJSgtWm1tCttCz9V
 /UdI/BkL62VSLjErq5/phjEMZwv8nNizQx3JLrbdxSFuN4K1GDNHbT2maz2yV8lsqbreCe0oG
 nFKMB6qXcPYVUOjzYcLViffiaAGrEaNnrpfBJGb137+ib4s5HahEc04lyXwRmnf7yTEdve4ds
 SPhlAw4fxvZ8xvMkU5ch+6OSLCBby127lic2eDzQd3UygvNcwfmoBXdTNx3jRuMt58Ufs4leh
 gXwU83D31ZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.19 20:14, Jonathan Corbet wrote:
> On Tue, 14 May 2019 19:48:12 +0200
> Toralf F=C3=B6rster <toralf.foerster@gmx.de> wrote:
>
>> But this link is mentioned in dmesg of 5.1.2
>
> It works for me.  I think you just needed to wait for the relevant commi=
t
> to make it upstream and the docs to be regenerated.
>
> Thanks,
>
> jon
>
Indeed, works now.
Thx

=2D-
Toralf
PGP C4EACDDE 0076E94E

