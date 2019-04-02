Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403F1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1874D2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfDBKh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:37:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDBKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:37:29 -0400
Received: from [192.168.178.52] ([109.104.50.84]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3bb3-1gkDQZ2n4t-010dd9; Tue, 02 Apr 2019 12:37:04 +0200
Subject: Re: [PATCH 05/16] staging: vc04_services: add proper SPDX identifier
 for dual licensed files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Aymen Qader <qader.aymen@gmail.com>,
        =?UTF-8?Q?Tobias_B=c3=bcttner?= <tobias.buettner@fau.de>,
        Dominic Braun <inf.braun@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Alejandro Ismael Silva <silva.alejandro.ismael@gmail.com>,
        Phil Elwell <phil@raspberrypi.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
 <20190402103203.14959-6-gregkh@linuxfoundation.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <e78cb1c1-8c57-7499-36ce-e401a02fe469@i2se.com>
Date:   Tue, 2 Apr 2019 12:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402103203.14959-6-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:8K98nb3DYCaYyUnmya1a/CmlfrM1ZUTJKMnMNYPYAiGEA2FtbWP
 HoZezODxskOkwr2YoFX7izv/ov20IEDszSWzHoiFmAQWZahzac1tstZ2aE2T7V6FHwL/8ET
 NVHLPyOD/B9rC5v35xKca6Svtj6W+8A5lNzZWtJoFLuyRxZSKIGR/mKdFEEzWxiFnv47+yO
 qfWPGzrQXiIxe29kx3w/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9HeFFDVxzRs=:KvLDZ9HVjnvOO1Xy6BaaJ/
 4Ippo2npn5MThIldtYbK3FWOFVocvUl443Ax6A989nxxHbM46L8DT2FF3YxoRd3VvsHClNSVg
 g7091+Hq6UtX69MKwhsKu6jTRbx5q+b3VN/AaaZb894dv7bVofj+EW0pcigiyD70rSPMbzyVQ
 2uR8P5gOdAS0xvvjwY66gpHu9sKwnifoyFXv1tTdsWTNGDJdYUl3V4+vZ1jRLFIKmacjjU5Y2
 2q8GaA6CZmVT1UzLRo0zpmM4fbrN8nS4hk5pnQJrOyeFsbguUUsBgx15eZAhoeNKXluFkWoL/
 gNJ868dHlB3hInS04gk4sLviFCdWadt/o4w17PvMhE7CdeL4xG2VO/+XWNPyEBdrE17WZVs69
 UIR5gR1b866VciDWF3oxAqQsLWLxPm+vWzo907gGs5n7LqwYYf3Eg4aPradhw4qDmdx4YWuLa
 OEoDl/IbbGiW83kYigQUD/rYh0bx7yfO8SGJnWQxZyJEyKjahKdTUOPPXrMZpw1yLpiw3J/89
 X1p8JpGCa3fO/pVue8hl3vWNd0x13zYHIUPwGcihrXA4uBF+Paj8ePe47rkt/10BHTBNrkPP4
 ccCihP/7topa4N5L+GGCXAhWsgf5Xy29m5t3s3SMuNMZVseBixTD/Wz9r9KAjgln9oPDLi7yC
 OmLkXsmoBBZHssGFeAUZ6XCnzN4Ai7yo6aS/suiiGk2p7mMkgEW8hOXAFIT498zw3sYCH4Bjq
 11XLML/B4gfup2tOTLfy3bQgCCjTKhxi2cAeXaVSJ/5LKWWUb7S72njEE3M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.04.19 um 12:31 schrieb Greg Kroah-Hartman:
> There are a number of vc04_services files that are dual licensed under
> the GPL2 and BSD-3 licenses.  They currently do not have a SPDX
> identifier on them, so fix that up and add the proper identifier so that
> tools can pick it up easily.
>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> Cc: Aymen Qader <qader.aymen@gmail.com>
> Cc: "Tobias Büttner" <tobias.buettner@fau.de>
> Cc: Dominic Braun <inf.braun@fau.de>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Alejandro Ismael Silva <silva.alejandro.ismael@gmail.com>
> Cc: Phil Elwell <phil@raspberrypi.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
