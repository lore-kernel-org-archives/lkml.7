Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19428C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F9320652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDOIEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:04:07 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50465 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:04:07 -0400
Received: from [192.168.1.110] ([95.115.91.41]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MT9zD-1hQhHK0lB9-00UYND; Mon, 15 Apr 2019 10:04:01 +0200
Subject: Re: [PATCH] platform/chrome: wilco_ec: Add telemetry data char device
 interface
To:     Nick Crews <ncrews@chromium.org>, enric.balletbo@collabora.com,
        bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        sjg@chromium.org, bartfab@chromium.org, lamzin@google.com,
        jchwong@google.com
References: <20190412224539.161321-1-ncrews@chromium.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <1d9add8f-6205-dfa2-d15c-c2fab29b091a@metux.net>
Date:   Mon, 15 Apr 2019 10:04:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190412224539.161321-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Rbqjkk4WKeRL6koyiNZrw9XUohTmygGUkEJEmL4X97sd2o3lidY
 TrUZjL+pkp3LIkulDqxfnWyKzMJs+VLdpbO7NnO6aDxE57t3ihz9c9ATYr2SNUMF/gpznjC
 FUM0tuTa7Pkq52sYesKQgOlslgE9vhTH0feReK2JG8k0JmQJxHPSx3NozDRoKjvHIFcXGPE
 eEvdRDCpWkD8df84CCnMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pccFocRQPc0=:Nry6m95lGOwYWaM3p6i6Cx
 EGrU5ZxASUnLKH1ePfoUc+Oexl3fKy0pHZ5J2MXJY+I22VIBXaiaEzu/nE1hQ2kEiMWt2B5x0
 lEJdTiptUPg0a6Ymg9UXOL7v68zU2hRS2qxz+Kmrky+j/qJd8QkY2xWAg8A3qwAdJH0Gx1Ei3
 ccCFr1DxCYfpOFdhqhIE9fgnuQhNV7wUR2xaJdoU9DLddJJjNEuKtzCQQBb91Qg8OUjX1jwWn
 mEZG3LBKMB4l5h2ierdoIGbJDPDIVmtxwwLIpVfsOBZZS4WWxineKC3XXhPlhq9Z/yl6xL9o7
 dtDhg+d/vmkVcZvsFo4YvMvfnvajHmk2cdhOwEqq6IShowYU76GQzK/1OPgp4Gi7ueuFdMtSR
 YMmfRBYnUGLHJqg+DZJEqX/G2HldmIZkCRqbFIMHQXmV376rGBXp7Uh02tO00m1+UfSkSHoJj
 Qw/UF6n4ksAfi1MmyTLacooRkDhMFSYhnf5s6rcX933nOCdhP2IAt48bRer8UjvVk2NCCG5dp
 +hxJeUYSpaeqSIdlULCnTy4opq+eZmmLaSBsex3Pf5X3j1cbiwVAxtMw9nvo5Ov0+K19FkifU
 JLcKxJ+V7aOzA0CWFY7YLDqn8J3QGETjSLrN5HyJlXxPTNMWn1w8HyexoaIssyDLpL02f7790
 PRLjQIvffTGiMGWk9Z1orpPIIglRjAjGOAUNRyN9Es7duxsBz/cr2AIFVbg5zGu7JY0Jd32gx
 bbEkfHYaGcgRZZT4o0EaI7Cgen3A+J/CP2Cou3bs38KVxff98rAwcz1KCTg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.19 00:45, Nick Crews wrote:
> The Wilco Embedded Controller is able to send telemetry data
> which is useful for enterprise applications. 

What kind of "enterprise applications" exactly ?

> A daemon running on
> the OS sends a command to the EC via write() to char device,
> and can read the response with a read() request.
> Both the request and the response are in an opaque
> binary format so that information which is proprietary to the
> enterprise service provider is secure.

In other words: a direct backdoor for the "provider", who can do
anything he wants remotely on the user's machine, w/o the user having
a chance of seeing what's actually going on ?

Seriously ?!

In some of your previous mails (*1) you indicate that it sends some
diagnostics information (eg. "dock is not working"). WTH does that
have to be "proprietary", IOW: encrypted = kept secret from the owner ?

If I *own* such a device, this is some information, I *need* to know,
I *deserve* to know, and it is *my* data, as it's a state of *my*
device. And that's some kind of information that *nobody* else has
any business with that. Period.

Seems you folks (Google) still didn't learn the fundamental difference
between ownership and just a license to use. And the recent multi
billion fines against Google still haven't been enough, so I'm looking
forward Mrs. Vestager's next strikes.


I'd like to remind you of the famous words of JR. Oppenheimer:
""Now I am become Death, the destroyer of worlds."
(quoted from the Bhagavad Gita, when he recognized the desatreous
consequences of his work)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
