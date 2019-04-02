Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB36C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470E620883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfDBKi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:38:27 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDBKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:38:27 -0400
Received: from [192.168.178.52] ([109.104.50.84]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ml76o-1gWffI0vBU-00lVkw; Tue, 02 Apr 2019 12:38:00 +0200
Subject: Re: [PATCH 06/16] staging: vc04_services: remove remaining redundant
 license text
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
 <20190402103203.14959-7-gregkh@linuxfoundation.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <a84e7740-cd9e-2d2e-fb6e-560776527e1e@i2se.com>
Date:   Tue, 2 Apr 2019 12:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402103203.14959-7-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:zdaMQH5uR6awRWVrSaA69WpUWHItqkjbrCx7PQ3ehpgdngni77v
 +1bT6ktliaco/HHHVl5mMguBA7Xv7nG4hSWOTXT98oR0TgRAEsZsHDl51iRKvI158+lpSzu
 PS10qYdubA7mMRlBAPlO7rzMu2MM1RcctFpYTT3g0iaJ7CX8F0FOkKxauOhRjK0nIlQiVaK
 f7F+ibcleh6yLHEEt7X6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Ftd9ThS86M=:Vfa2M0oxHJZOAAOUyzMcTF
 YcvHUvhk+3TRJfwvzZwxyIVRmHUSGeFNt5jV80B7pry67Hvs5snc5zdl9Pvde0nSKawtrcQhs
 0tWBX6T+zwVs/X92ksW3fXlX+WFFYB3qzUTn4Q6j1O2zM27Ceb3Wd4lgcyuERnHoVhZT7odxR
 /Yu8w7H6gSzs9qGM/xY05JalqvO+KLjvAgtgf/vXc5lWgHidcEwhzhbqhixdcewG3Em1sbbXz
 Ya/kugvV95Xd3ljVq4Skj3HxvlkVOp8nakY5KhlmnLMVEAg0kYytjm1oUFR4CD8cLA+cZb+69
 j4FbLX0RvG8kB1eo/tlp5cE3pMsQxw3i9WR60jHIYYTz2W8gjvDkM5ENVGg0K7tTKIZETuvHO
 C4HCCURNbhOAYn9ooaEm7YTcLuqJBDAtuGYKe6iIvDhtZYiowdY2hj5dRMWFCfoghsG6/F5LC
 t0Nq0OSYjFteatIhdvYAgsduJflLcB9WBI3nDzcJKj7QKgduFZhjIUDqLil1phrvbzXUJJmzs
 ofpz5dNz8fP/eOgSWxDB0G5kihKH56T1o/qrsMOPDI1SQ2zdzhIwe6jy3htRWbsClw4VE12WL
 obXw8aJrwGxZoQ4fHCb/iNrnCR3R3EGHlY7wixkD5ds4+8RAfLIfEPklqMmxcRrABuUOepEti
 MhN0OriF1WfCDV/9s2Fx1ZB0AVvdUhLqpWZWsuXrBhGvKMuGKv44Stbe69uJs4EhrlpVeAtve
 vzUXbpGeOVtNcDmOmLcl/o7mpFsgkbE3MQBO9qMnhPMpHoczqiIpmA/R3KU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.04.19 um 12:31 schrieb Greg Kroah-Hartman:
> Now that the SPDX tag is in all vc04_services files, that identifies the
> license in a specific and legally-defined manner.  So the extra GPL and
> BSD text wording can be removed as it is no longer needed at all.
>
> This is done on a quest to remove the 700+ different ways that files in
> the kernel describe the license text.
>
> No copyright headers or other non-license-description text was removed.
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

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

Stefan

