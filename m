Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD66B214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfCKRZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:25:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:35802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727641AbfCKRZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:25:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D8C8AFDF;
        Mon, 11 Mar 2019 17:25:57 +0000 (UTC)
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
 <20190208121916.GE23483@kroah.com>
 <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
 <20190208141400.GA22162@kroah.com>
 <CAGngYiXZtNcqQ3JGgavBxypo75WtAT7T-X4DQFNWD8kQcifU8g@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <c8632a8c-dd3b-6b16-3fb2-5a1b381ca29a@suse.de>
Date:   Mon, 11 Mar 2019 18:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiXZtNcqQ3JGgavBxypo75WtAT7T-X4DQFNWD8kQcifU8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.03.19 um 18:02 schrieb Sven Van Asbroeck:
> On Fri, Feb 8, 2019 at 9:14 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> Well, who wants this code?  Who uses it?  Find those people and get them
>> to review it.  If no one wants it or uses it, that kind of implies that
>> it's not needed :)
> 
> We have customers who (will) talk to this ABI from userspace, but they are
> not 'Linux-y' enough to come to the mailing list and meaningfully review
> the userspace ABI.
> 
> IMHO the current reality of Fieldbus on Linux is companies rolling their own
> proprietary out-of-tree interfaces and drivers. They do this partly because
> there is no existing community or infrastructure. So there is no incentive
> to be involved with mainline, which could also explain why no-one is commenting
> on this Fieldbus ABI.
> 
> Chicken-and-egg problem ?
> 
> Greg, could I convince you to take this Fieldbus subsystem in drivers/staging?
> Perhaps its presence may kickstart or seed a Linux Fieldbus community.
> Being in staging/ also means that we can tweak the userspace ABI to our
> heart's content if more people/requirements come in.
> 
> If there's been no meaningful activity in, say, one year from now, you may
> decide to send this whole subsystem to /dev/null.

I have two unfinished drivers that might benefit, for Hilscher netX 52
(multi-protocol) and Microchip LAN9252 (EtherCAT), as well as a Linux
port for Infineon XMC4500 that might be expanded to XMC4800 (EtherCAT).

But currently -ENOTIME for review or development, sorry.

Staging sounds like a plan, if that allows us to still break the ABI.

Can't make any guarantees whether I might get to them within one year,
as my LoRa project has been turning into a Black Hole. ;)

Are you at Netdev 0x13 later this month? That might be an opportunity to
discuss the network-related parts such as Profinet and EtherCAT.

Cheers,
Andreas

https://github.com/afaerber/netx-module
https://github.com/afaerber/lan9252-module

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
