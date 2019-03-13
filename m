Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD864C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D22F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfCMROT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:14:19 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfCMROT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:14:19 -0400
Received: from [192.168.1.110] ([77.4.24.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MOzKm-1hP45C2Cwm-00PMeu; Wed, 13 Mar 2019 18:13:42 +0100
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
 <20190312163356.GB13549@kroah.com>
 <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
 <20190313143654.GA7489@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0458c818-085f-53f3-4078-557fa752854b@metux.net>
Date:   Wed, 13 Mar 2019 18:13:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190313143654.GA7489@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QUXIJDYP2VEyQPaVNa5Y3v5Zlqke4T47/dtFtd3w7KJQJ2FisC3
 qVDY63EJMJ8gi7q4zZPDEBMqJiCQDPfWUemW+ZMwYe92Pv7eOp1rirPE4V21CfCrY4ONvko
 pa3G4RiLDv3itLehtj5/dcRZpiU814RpzwPLQzOzenNSqw1kdizy/MMumFWlvWdjHnxtkCb
 6fCWqaVP+RYI6kxa0GJQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ci7oyJFuDEY=:yCPf6JLnQ5EmXY7NS4v42o
 xnEoH2+AiVratzrJfDGsEysoFP46ChRzwVtPRJuwnpGa/ui9AIyOBRLlOexXV8iSlK5aFuASx
 vy+xrE57Mnt7cEHm52/MQjkKYAny4g/hodBQp2QrXVV3IHYENms+SCwa+toQDfpLKi3E8e42r
 5B2P0+qRJaEZKYreWGO3EjpPBjvRO/DHr3N/P/0dxk5rTHZMGzoyGZV4ACLGn3fEC5Akz7CWP
 hN0eKHcNrCLeX3AOC68B82+GfU6bYgLoTCVbAA3xnxdGbP/keimemDh/0PnPx5oczE7TBnLzI
 Y7gEeSxung/V7goYvj0Bsm2S9bQ3yBLJAA72Re3qpS2LjIlJFqJS/E6i+YgNFKO2T2BjQCqIy
 nH2XoOCru4MUVMNsWjA9mHztvxLrY3aUrdUI6ffmcCwhhF4f60T4onfD3HZH+X6eFhFtAI2ig
 t94D9xeO0+e9pXT0r/5Cket5kvsX0oWKzxGLpWk4sC4gcCPrrbt2mAhDdSGXvN0w1kaXWEv+J
 QPnDKTa4gsUpgptsTFl+Ar2DzTWYSglESLxQI62ikeUkVgctV1R7Zh7842l0Nuszv2oz2NaAJ
 dikIxzj2nBj+x09NGgNfNep3ZkI/GLxK1pHERJf4TdaV0HFsPflbDlKRspeicZS3JBlwseIDX
 xcPgXtUotM7kgxgYAtotG5N1iIHUIikQcgabm6wHgMh+f5BdXeUObUrYKI2N80r6osr0Yy8LF
 tU6mJMmkYqpE6DaqPoETeTYH1JLrN4n4kGirUMvtZE9B3+OkqMw8BUO/7u8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.19 15:36, Greg KH wrote:

> Also, usually RFC like patches and series are ignored, I know I almost
> always ignore them because if the author doesn't think they are ready to
> be reviewed, why would I spend time on them compared to other patches
> that their authors think are ready for review.

Okay, but then, how is the best way to ask for help ?

In my case here, there're several things still unclear to me, eg:

* struct uart_port -> mapbase:

=> seems to be used by most drivers, but some also clear it later, eg.
   uartlite does so when uart_add_one_port() call failed. is that
   really necessary ?

* struct uart_port -> mapsize:

=> seems to be used only rarely. most drivers use either fixed params
   on the memory mapping functions, or take it from some function.
   wouldn't it be better if all would fill out that field and later
   use it consistently ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
