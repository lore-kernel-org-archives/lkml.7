Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA8B2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCMOJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:09:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCMOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:09:33 -0400
Received: from [192.168.1.110] ([77.4.24.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mnq0I-1ggbSW01uc-00pNuW; Wed, 13 Mar 2019 15:09:26 +0100
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
 <20190312163356.GB13549@kroah.com>
 <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
 <CANiq72=SBFzRVhpkH8V+=5E-adzJ4v6UGAPKfr18wnCB0rcoQA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <939d94a2-f44d-27a6-e894-1f846c6b3b5c@metux.net>
Date:   Wed, 13 Mar 2019 15:09:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANiq72=SBFzRVhpkH8V+=5E-adzJ4v6UGAPKfr18wnCB0rcoQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:157mBowVaUiM7riybT37RvZxeAu1+1jPROG+l2QZgX7NrypCRHw
 ufz5m1ZaxbCR2cC/Oa6qxB4gGoLdPsgOqbDg9TM9WkwhvVE5pQIhPEqMD5fbWyJNoKvVKx0
 NRzsUhpEPQ3xvu1RIAqIUfzvORanbU559sS3zK06Vlb8CEGYnztkN4slLjJhYDlX8zyyNzE
 t9oaXlkwgZWQUbBPpiBsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TliYtZdi++k=:EZs4T1ZX0FEH4kho7oqtD2
 4jtuVmE39BkDbSXVXhrB4uwRNuig7q2wfa3F0GTtxrMrazEqrkzPPp8nvSIc0dW2cjdHFvKZc
 /0WINuVfmxbYW64JW7MO40tkTlz+M007psWTa0o/1h3W9aCag+Dp/Kwr2Ab2+B7tCudMe+ijS
 QVDxn//Op1N148ZNWF+KvdQP7p8z1z8srDeLl7jXoxsByTbAgz4yVS7Li+PfiQgp7spyT22bX
 AC2euT8+x0Z4H9ActhwmsyvrQNv8O0pNXJBZ45q2LSeOQrp/Yc+prLSOD8PJpAr5MHJQVanOa
 qEEqkje0vKuix1eFebHMgApTpY6CfVOpME6d5G0XZp4YA5ZBuB85PoUtm8+u5FkCKbk63pUl7
 OkZipqJEC7QNXPvW2s/EZxuNpE4gIlLpkvvtibjG04UjP/0laMWkkSqQALaDeI8AgJ84i+Pg2
 7ZVRSHsJgtd6xtcwRtDUF5Vk9gM47/TAFcdUg5QXfzA4zTxCoH4XTSz8x+kf0MgioWkFVvqki
 wwR9x2lywyNxQ/HeWka0Wxqc99ANg6OUHKxupIPOJ3CZFK0eXGllqHIY29HROUrRIaDr78u2l
 /oWLYf7rPbMc3lz7B60FwkhpIzBeYcNK3BVjS3cPV7oTNRHwzuotf0GxR44zyYwRAo1KMDoH3
 feTTiNwVxxhIkaqFP95ejC9bPwVjI7+RU2k4dNSISLOpTro77t3BbX5ih9Pdg6HNWWjsM0/w4
 XrU84UsUHpCML40vSrxSTT3+/ZIsL521UgdWJ0sKPTRjSdxOTeRMUhjCxpM46CedxdDaP50fV
 j/L706gAK+5Xvki0v0MovcenC7/fbaTOyxf5ogDCR4LzirLb70XqWrQipUqpwfntityzfkv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.19 12:28, Miguel Ojeda wrote:

Hi,

> The intro letter seems to be an independent message with a different> subject line -- not sure what threading you expected (?).
hmm, I've sent it via git-send-email --compose. IMHO, this should
send the intro as the first message and the actual patches as reply.

But it seems that didn't work as I hoped.

>> I wrote that this is yet WIP, not meant for actual submission, instead>> just to ask you folks whether my approach in general would be work.>
> That will indeed cause confusion. If you are requesting comments
only,> please do so placing [RFC] or similar in the subject of each patch

Ah, good idea. So I also have this tag in the git repo.
BTW: are there more such conventions I should be aware of ?

> Another option is sending a message with the repo URL where> development is happening, so interested parties can take a look.
Ok. I had the impression that people here don't really like to look
at some git repos for reviews.

> Even if you are sending some draft patches, it is still a bad idea to> send them incomplete. Basically you are making it harder for early>
reviewers simply by not having written an explanation or at least a>
reference to the explanation.
Understood.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
