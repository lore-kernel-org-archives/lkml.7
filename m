Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E00C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCBD2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbfLKPdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:33:54 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:40051 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730954AbfLKPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:33:43 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M8QiW-1iagGz3r5U-004So9 for <linux-kernel@vger.kernel.org>; Wed, 11 Dec
 2019 16:33:42 +0100
Received: by mail-qk1-f179.google.com with SMTP id a203so9852840qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:33:41 -0800 (PST)
X-Gm-Message-State: APjAAAUfwHqUwyRjRLa0V8vUcSrNdYTKsyuJsRftKD+spi9pkAz4Zijb
        U1G+5jfGL0+5nJPVPJH6L377omzNs6G4n8TfCjA=
X-Google-Smtp-Source: APXvYqxmeB8TjlMCMi/FqHf6Gou8DAqv4Puz6Gm0jsLC3WBKTCxWNeE/74JK2vXpaV3DnctI1gXS0DxSAbNlFi1R7Zc=
X-Received: by 2002:a37:4e4e:: with SMTP id c75mr3368164qkb.3.1576078420833;
 Wed, 11 Dec 2019 07:33:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575977795.git.vitor.soares@synopsys.com>
 <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
 <CAK8P3a1cwoTbT3zsa-tfApwewDT1-ksHZs6_vkBYpKbgptsfjw@mail.gmail.com>
 <CH2PR12MB4216E04995E421F04B7662DEAE5B0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <CAK8P3a00wfUbGU1a9nS1dtDsUo1GR1V1WqRwa+DmUKVStvicTw@mail.gmail.com> <CH2PR12MB4216CE03448AF3B39C23D3BCAE5A0@CH2PR12MB4216.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4216CE03448AF3B39C23D3BCAE5A0@CH2PR12MB4216.namprd12.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Dec 2019 16:33:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2vRG9uiY6jCRip98DHVP5-FeWk_sToGrPSA_WcY0agcA@mail.gmail.com>
Message-ID: <CAK8P3a2vRG9uiY6jCRip98DHVP5-FeWk_sToGrPSA_WcY0agcA@mail.gmail.com>
Subject: Re: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HwUutlWxhi/qNhj6rzdE4KlUvk+XYIo6tvEYWzJJ8njRHPRPTpX
 piC+yOdBKynS5m+VAUeKRvMHoFhIcR0H+A2WBbf/V/X4Kp4wP//ixA9/wQQgMgwqsxvJGZC
 rtC/qgtOFhSVDNi2dCq7qmGlILFet/r/Embr7DPz7S+nebMJu1IWfVqFT2KrTdd8lWf7ujn
 tqvhLw43GEk+U0IUWmgJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bwReUF5jPXo=:S37LbxcmkNXcwIj7f5cNTz
 tFGPBMRz+9fg6GrR+bpa5B0h9d46tElGfLzVLrBVIpauKyKi8tpNGzxKt4tKnh+/DnMcWJ2QB
 rLp+DzbJO9VcASf2A1TGkVrxSX79H9YF5cPlaR36s9Fa7kmyA6FE5CfgsFSz/JgQjJ0dtSySN
 PBb9PnaR62Rw0yaR/RYQB/TAHXDAK6FnV6uHb2WuoXdPcu4B5pN3kK8cXifEI6RCzTgJe+On9
 NYI7WD6PoIis07NA8NXYydGNSA+pwU38DRu6fPSEIb32gJjK8z5HmZgoJHvp6vVFXwrSuopEC
 Z8Xwe8HGb1CCeJ/jlE7/gv1axExC5Se0x5SBREW/MzTVsVdjESlD/L2TVREQOlbaPoq/Kwh8D
 QvZqvuGI/pC4uzgGgNBX4PsfWI3cs9APrx32sJh3O04kaaKybVmyAoaolLf/DWfWxcakAP0fm
 42FW5Z06S1qRMDmF/r6PHh7SsLXTlB66OoVfWNL7a4Lgpy7xza+qKk632cOrwL12Brf2l3cMD
 Aq+fEDDaQsbMWDfbyWczAxoTlftyiIzuxyhXbcARJIVbs+6mjt0Q6yHgSqYTXIAo+S/QfS2O5
 TR2cSD+FJJHiCRV14Fguf9n7W8bMvDxrU3b4sb31fLEiG/mM/44d2o0OzM8/FLKmeCK0UwhEc
 6Uf+PI8weWhqfk23KjYSDjX0j5jfynD1CWbmcn3FID3mHADy2YiGFbRgI1MYo74mS8Widinz+
 KJ7Mn30qxUxi51igy8DsZiCYnP6dp5awOR03M+iAcG5KXqNq+0PH+2grehZZbaMhNC5J5oTAH
 xsvoV9vcRDJJ9f8V1voYjEcM/dXQ+HRqEPpcLAebt0yT3plJjot6cs9Sts7FMazEgE3Z009Jz
 g7H89ldDqBIvB62BhxSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 4:07 PM Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, Dec 10, 2019 at 19:37:14
> > On Tue, Dec 10, 2019 at 8:15 PM Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > Date: Tue, Dec 10, 2019 at 17:51:14
> > > > On Tue, Dec 10, 2019 at 4:37 PM Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > As your interface is basically just read/write based, I wonder
> > if there is a way to completely avoid the ioctl and instead
> > use io_submit() as the primary interface.
>
> I confess that I wasn't familiar with io_submit() until now and went
> straightway for the ioctl() approach.
> So far, my understanding is that io_submit() will call .write or .read of
> i3cdev module depending on the iocb command. if so, we won't be able to
> do a repeated start between a multiple iocb in the same list, right?

I'm not sure what you mean with "repeated start", but it's definitely
possible that io_submit() is not a useful interface for i3c. The main
advantage would be that it avoids creating a complex ioctl command.

> Apart from this private read/write need, another requirement that leads
> me to use the ioctl() was:
> - When we support HDR command in i3c subsystem we can expand the ioctl()
> command to support it.
> - For now, device API doesn't expose CCC commands but some of them are
> used for a private contract between master and device and we likely need
> that support in the future as well.

I think you could still have both the io_submit() interface for basic I/O
(if you can get it to do what you want), plus an ioctl interface for more
complex interactions.

     Arnd
