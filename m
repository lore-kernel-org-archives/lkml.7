Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F9C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF3A218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGCMS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:18:57 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57023 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCMS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:18:57 -0400
Received: from [192.168.1.110] ([95.114.150.241]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MFbmS-1hkIsC3VvC-00H6cu; Wed, 03 Jul 2019 14:16:55 +0200
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        backports@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Daniel Jonsson <danijons@student.chalmers.se>,
        Andrzej Wasowski <wasowski@itu.dk>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de> <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de>
 <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <40f70582-c16a-7de0-cfd6-c7d5ff9ead71@metux.net>
Date:   Wed, 3 Jul 2019 14:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:W1x9k6V+ILJLTptyvRZZehGm7oOh188B4CLlH8SDPNOMPl6mkgL
 jwh0gmXALvMKQ4QkJaDBduAejwvFFp99TX7tMmfPMp6/Dpi0tkOW5Vc2SXzFeZqTGvmGb5Y
 HAYYNuC6Zdm3DbpjV5aoBc0pQCIBGck52IAZ0AwhayVJboHeRay4HUUcqSLO1Wf8jbO9wk1
 0SCzRRtgb7tB0OH4MzTsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WAtJgcwxvoU=:0kmEfqi451hPUIuRJpYyTG
 a4GnD3P2+1ZySKAR+DRfEbJgyVBnoylrvqvBwRReBdXZpfdeKejKNy3yUDAFD/7K5kXXFauYg
 UhzsEPInu3J1+7YyfAosnCb+hog0ydu0KyACei8pcZv1lfeffilhFcokmwQa9V1Deys0c7+81
 1m+4LCKd1KxM9gVP699lhg8zFJddDWYVL3Y0+HcRBQXUYQ15r/jcozg8tGRfq2SRPfFdCYrNX
 SZ3ZDEEVP5Bf8g6lyEDiR/LfdaM9BBM6d4WPU8vdS4myU1mYEuzGm8YJI87RvYv+ngHEvzlNr
 tBjknxuzp56tuWOi+vuaCU/Cr4g9zAkdMfrlHrXNsovVHtMONkLPQAydDzvQK6WnW2kCm0m40
 AeZxso0aibZqL/e48hYl/o4/ne4oe7aJihzWdOknbn4dfCW8Ee6BDTxLC6VvAJnwi03bb5UWb
 2eom04i8VSqMCzLjw72ZIb0Vp8DXbYA2tkR0q8IXBGxTk5ijHGXqWCaU10TyF18Foaiwa5mwT
 Dvx6tqdMfkyWaz3LM4wU0XeHurVba/ZFK/iYtD4FumEc8yUseDNoe8qR7pIOxMivxAbvCzgRn
 Has1Um8+1KKg/fmi253tN7Ie8lreycS5eGqFKk+jqlWvFYzjxBKSk4tEx+k3Hencsm/KzkRwT
 GRUt6KTYYgS9LNoDVeSH37fwr3MRgTvqa39ybtVakFxB/X99d8YuWLvQzYNrKSCuW2hnoxB6a
 a13bmJgK7Yj2qw9kJLymTcKC7AH3GNmVyGabQMc8x5cBqEB8PiBezdDgtdE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.19 20:40, Luis Chamberlain wrote:

Hi folks,

> The solution puts forward a mechanism to add a kconfig_symb where we> are 100% certain we have a direct module --> config mapping.
Okay, but IIRC this will add more boilerplate those modules.

And I wonder whether target binaries are the right place for those
things at all - IMHO that's something one wants to derive from the
source code  / .config's. At least in the cases I'm imagining, I don't
even have an actual kernel running on the corresponding target yet.
(eg. in crosscompile situations)

OTOH, a more pressing problem for me is identifying the right drivers
and corresponding config options (usually plural, as certain subsystems
have to be enabled, too) by hardware information like DT, ACPI, DMI,
PCI, etc. For now, I have to do that manually, which is pretty time
consuming.

In embedded world, we often have scenarios where we want a really
minimal kernel, but need to enable/disable certain hi-level peripherals
in the middle of the project (eg. "oh, we also need ethernet, but we
wanna drop usb"). There we'll have to find out what actual chip is,
its corresponding driver, required subsystems, etc, and also kick off
everything we don't need anymore.

I've thought about implementing some actual dependency tracking
(at least recording the auto-enabled symbols), but didn't expect that
to become practically usable anytime soon, so I went for a different
approach: writing a little tool that allows modeling hilevel features
and corresponding (potentially board-specific) config syms, so the whole
.config for certain board and usecase can be autogenerated by just some
small meta-configuration:

   https://github.com/metux/kmct

Maybe this could also help for your usecase ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
