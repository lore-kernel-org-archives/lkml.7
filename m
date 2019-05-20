Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F95C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EBE20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfETMPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:15:10 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47087 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732031AbfETMPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:15:09 -0400
Received: from [192.168.178.167] ([109.104.33.162]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTRIi-1h5hDG1oZo-00Toay; Mon, 20 May 2019 14:14:30 +0200
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update pllb
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-pm@vger.kernel.org, sboyd@kernel.org,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        ptesarik@suse.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        mbrugger@suse.de, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ssuloev@orpaltech.com
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
 <20190520104708.11980-4-nsaenzjulienne@suse.de>
 <ebc78880-418f-f507-021c-41295113e041@i2se.com>
Message-ID: <35c11eae-4ebe-16aa-0d87-1858e90db5d6@i2se.com>
Date:   Mon, 20 May 2019 14:14:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ebc78880-418f-f507-021c-41295113e041@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:Na5P1m+iImNGn5ACi7WqolQFQrJ+a+S2wYFesqD/c0odb8talYi
 dO/IlbSPb5CQQnX7py/vyFeG3JuNnBeXrPs2MX4FV7gvS3/JbCApn+cg6u/8p24CC9bwQIf
 3ToynHXvPnjXjrk5bROgbn+PUofrec0gNiO4gShhgPW8fodfI3RHwcKVkA0tCPYwTqXxZol
 w7aB96DY21wjqUUtu57Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKzGkiXX4Zs=:7WB0oAy7PJ9WTHOuTM33H6
 1cmtaA/5o8RRNo14+64yWga0+CxcL3GybAl5TBqk6AUUsOIk7nJr2h38XRMAxTdBZfTtQ/UVZ
 qCk+wM3vnES9nMb6aJUrQp1tYe8653oL/g3Cst6xU7eSIbjFukpv/02/pCOQmmwOxqjqlRclQ
 9hpoOWHp945MRIG4sADRCQntxLMLLrI1ZItxKOXL2wIeSG5MT89sIzv58FsSAzmKPzB5GNsbm
 0zBUIqndTQiuItth9W981qti2oF2uOIDaPyq0xRug/6FieTxSJgEkuYskPReyYiN0GCyRb7d0
 M4ZBL8WHwHvI8IKSZBdOP9sNP1wpl/kW2ISM4FqgAF/W4Ydx9R/C221FFIUqQrfzz5IL/IfQi
 4Y5J0PlgmuFrOPJsfEwzZ9RgGPOwl90b73cyYD4IS7Ob5ymYwrFDPuSQpEHOMkmRVvY0wfD+F
 8EnbV35m5bXCUT58d8cJ/jeE892gQ970CRk4ijPe4IZrAIxScQvOxCsm783Jj0tZgkEz1fsz9
 t/qBH4tV981TWmW+M13DV5B70wtaessIzqf5c/ZLtAoits/NiCjOroK8enMH1ITlEBBboeoeG
 wcGOjDCr+3IWX40mGniyQS1FNBMlL+w7Rm2cW87mQ5H7AwF/goVEe64c9h3efnhw6BcBPl+th
 VVBGzPLyZAc2eapUibxCdh8h8EYBjZ7tN2pnjsfcCp+nQ6pN1y9J5QKGOCNPx6MgK1JOx8ug1
 HrZ2gD/JRsiivELtNumxdsDyAzKmr0l4ch0Vvt7TrZI/662gOVeWQTpVwD8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.19 14:11, Stefan Wahren wrote:
>
> Please verify that the kernel still works (and this clock driver probe)
> under the following conditions:
>
> - CONFIG_RASPBERRYPI_FIRMWARE=n
> - CONFIG_RASPBERRYPI_FIRMWARE=m
> - older DTBs without patch #1
Sorry, i meant patch #4
