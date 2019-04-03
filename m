Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD677C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6CB20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfDCHLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:11:23 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52933 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCHLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:11:22 -0400
Received: from [192.168.178.52] ([109.104.37.190]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N49Qd-1glYrD1kDB-0100yA; Wed, 03 Apr 2019 09:11:14 +0200
Subject: Re: [PATCH] staging: vchiq_arm: remove space after open '('
To:     Mario Balan <mario.balan@gmail.com>, eric@anholt.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
References: <20190403030713.19280-1-mario.balan@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <8bf57fcc-d6b0-3040-206f-736acd722a80@i2se.com>
Date:   Wed, 3 Apr 2019 09:11:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403030713.19280-1-mario.balan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:rGv+wc8AEqCVC6RaAgalD+shkve6TIVnMliUNuguDXLZQ3KfXER
 kVUQ46S1weiCP1Tr/2IuOw9kkN+fY8NSICFOo8UqVHZRnsQ4TXxRqlvKVcjJnlhi2WsGBHk
 ilNiQPaWVHku4COMewV4uVLwW7rDfLU99evypmaQtmwawUN3nXmyNDk8SmPZ/eHTQixTZvY
 dI9m8ZsSOrDYyYf4JAksQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rsv6M+Z1y4U=:jEeeAbYKnOBJHESxv+4zq1
 ukxBoil8oTiL2oa5i45aaDgS92xCT04aS9kuPK2eyaVOy6eWF+ndlSmM/3e7YMK/+vTjl9ZmI
 prgh/IeCQRNr32HQVjEKhB2Jan1NKdoZZ8JVv1+QPytHEp/ZvjVW/ChQQlyqzBJPe0jC9IGf4
 IAI/eXDE8jNEYGHnCu0Tu0uBQognr5KJ0rmTJZ+QL5ebO38pMqqWUXuVcwzrTgAsU03yQEoVn
 1rMoUjKQMrCNVkNRPaEq4FHtahl8eJF7erCvd0VzCDThOV5sF1IU4fQjMFN0+GrgB1FOZ01Hm
 NdYTwXzqx7BukdA2OiWUFNxivoeaETKWmeSDHXrzmOQ59IUL4TqIgEuFDzRny0khHV7hcYxl2
 r13M54jN6OT5GMf7DacgQHbFhHaRnmwMFD4vZJyPr04QwTa6mFVsiM9WIJqCdN47gk3oUKtax
 U/DLVilI2OLrmV/K+dsDZNrU24xemArf98Y2mLliPrleQkTFF54wNeOyof3XbXeg63ro6NOa7
 HnbFrQFrH+n3AbtqlDU813FilVQGejIP1AmLYAoNHntgCN19Mcy1FN8UGAR16H4MYgCqUixNf
 VX/QEdMLmLPEJyAp1tC/bxuLne008siaerf5tu4MQBSKWiLYmsGy+chQb6q9IvLXROITPF2BM
 MZtKSQO0+Wwqz9JNNB6kbYaCnmJtFaVMLVZnPtR3BcpmRUC+oDN2LZQRu4CX3WfQVNzQkckKp
 4qpLtn8WMtAe6LAy8Nsaq0KA2TY3xC71jP3/i5XVZjBATOGpOrv4YpbMscQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.04.19 um 05:07 schrieb Mario Balan:
> Fix checkpatch error "ERROR: space prohibited after that open
> parenthesis '('" in vchiq_arm.c:563.
>
> Signed-off-by: Mario Balan <mario.balan@gmail.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

