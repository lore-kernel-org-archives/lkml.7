Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67B4C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27412173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfDQMXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:23:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:38965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfDQMXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:23:30 -0400
Received: from [192.168.1.110] ([95.117.89.119]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6KQZ-1go4on3fIH-016deW; Wed, 17 Apr 2019 14:23:16 +0200
Subject: Re: [PATCH v3 2/2] ftpm: add documentation for ftpm driver
To:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190415155636.32748-3-sashal@kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <b2c1b45e-515d-1d91-e3d9-5f9078078cae@metux.net>
Date:   Wed, 17 Apr 2019 14:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190415155636.32748-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q4mIZ6PRvzl7CkhdTRWxQzpE0Qr0lw8fOeV0IjANte9Nu5XLEWc
 YDX1j11hPb+OKuezAvoRxufl6jGpJ7y7C/pA7Uc+HXVk3kHZRj2ghiF4SgrFm0GUdtBXP28
 9Vmzz7AG59VDDWnp8kmnXfX45nnC6atxKRGAJi2c5T4NP/dIdySpC28it/LNARuL3qDG+IZ
 iubXd81kavOmR7Xl1F2PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:htORYJ9y9YU=:sAjJigSH1/tKTvt7wkyqHE
 DhIN5XvSEprfRjbBH8QtS4FPXrPcf59mcTXQmkYODWAkJCOZZXgYvaxdYASDNuyqSM5u4LB7R
 +EEn3UpCn9vx+bCVkU6U/ZwXCfXIVbqfHC7IQ+ZEVqxVOFQzRtdDYD+nNqpD+aMcNVEKfIu88
 8JX1fzzLkH5TGpVk8Dal1AYKDWviTsClbawd7Mf/1Pb/tsSgFfN+pa1Y0mA5FPgEzijDc9Q6O
 QD1Y8xxbkiK6re1ki779WG2YYf0GSsdCP+Zp5aCmoadGFK3SAc3rdlctXXcautqkIU4lBXJkt
 ZcLc4M08XmlJJ6ciN2lxwiBWgnaZwnobIkqS3bpcmoR/xca88jVe74E0yHQBMOuRermFUxXdp
 YV1TlfpDJjvy6Lfk96xqzec9r61+aYVQFUT/9F/BNg0G9feHmgBY9JcCCvqoSOqL8/eljKeav
 cfqBbYOYDNtU0T6sMEwDaIeiULaD+LcozXZBntbtpjylKS/mz5pux65dy6fgEFKgVl/MPDJ83
 jerJHR8c8HFK51d2PtJVYYIhadxZWQGVRcgw1WOkE0kWK+++25akfbfcYdFzuwYKbyBHAZESa
 92MuQe7Hx1yw44nEQDZxlRwTX8F6dFeCgrRC6QA+m63+tU1+hrAljuWKtMFoN26SVRrq/dGam
 m7nIrFyOOHnqwHPWYs4j/dU2j+H4UDVXNgJyoKZDoPRrUh7ukruB6s4v9Hjpcq3VR9tNgYxwR
 6R6MDyrkK1rktH1Mvh4Ru4v/HP5WoIrNlJtHrciNb/sd4YKi7TRj53i9wrI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.19 17:56, Sasha Levin wrote:

Hi,

> +The driver acts as a thin layer that passes commands to and from a TPM> +implemented in firmware. The driver itself doesn't contain much logic
and is> +used more like a dumb pipe between firmware and kernel/userspace.
Is that TPM already used in production or yet an PoC ?
IOW: can the protocol be changed ?

If so, I'd prefer using 9P for that. This already proven well, not just
for grid computing (where it originally came from), but also in things
like virtio, etc.

In general, many of the hardware/chip interfaces out there basically
deal with either either passing around some data packets or streams,
or reading/setting some attributes. But everybody seems to do that part
in his own special way - that takes up a big share of the driver
development resources and final code - and that needs to be repeated
for each OS. In many, many cases a standard protocol like 9P could
already provide this - if folks would just use it :p

Therefore, I'm really a strong supporter of the idea of using 9P
for this.

In your case, you could design the highlevel TPM interface like with
a tcp stream / socket or a synthetic filesystem, and for the lowlevel
part just like kvm does w/ virtio.

In case you have no experience w/ 9P+friends, feel free to ask,
I'll to my best to explain it :)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
