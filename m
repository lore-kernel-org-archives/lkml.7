Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41517C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CE02075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfDORmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:42:42 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50597 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfDORmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:42:42 -0400
Received: from [192.168.1.110] ([95.115.91.41]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNKuK-1hVzed0FwI-00OrvW; Mon, 15 Apr 2019 19:41:15 +0200
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
To:     Sven Van Asbroeck <thesven73@gmail.com>, robh+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190409144250.7237-1-TheSven73@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
Date:   Mon, 15 Apr 2019 19:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190409144250.7237-1-TheSven73@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+iJ2uT9q22Pl6DI/mdS0E6DQwRGemcLJv6kIJ0eKJK7H8U/ompX
 7Fve8AMTez9ek1ewfVDRXiBTo6iJIZewq9US6h4fSpzn8r9P35Ulkhkl0EaHKLpbhMfqVJT
 uvEgEsvf+8UAS4aY1nZzN0jV6h3ACNVcaY2gIR0rw3imVhgQKqrthGDm38l35+xB0ALjD/W
 3uFBEUdWK7YsNmgBOMKSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:muT5on7HOqQ=:cOzZYZbnJufdgwHbeyzXwc
 CN/c3GYF+F5SQRLYjsmpHYH07n/4ieO76wtLaijG3AbO5/oGaG0i6iIb4hl4NsnCAW85bbu83
 +tsUeOEBdbzoQ8HNJlSZHPrtp/glJ7Aop99zMayTibHG3znOmAAtZy8h5htL4bREhvC7wHxVR
 RTZvF3OJQVVausgsMmia8m6V5vIrxuVREhj3ZmlTsRDnCdJOU/IOWejPTXPPaq/gTYks+XifH
 Kdz/lnh6na9Gtd/aUDYMT93At7GjzGOoxZrqHIJSRRAfeuq7SWzIJKxLaXNgAKoJgqpqu/S9s
 zObdzcnnb7MHfnrlLnjYN7W7PUPsLEsw+xlLPNEdSSe2Ftbwen8mANyNehCyrYAzhmdPwQcoi
 Cxn438XZPCDpwK8pF5UlJv6crFeDRub6kBHaWjkdmt9Z7+yvnBs2nTBEDhE60KYhFtzdbRikS
 FkaMHIaZgKRPb6WeycGEeu+ezJflDxXdvMlgtix8FQE7d0t/fV6ebfII7XQP5EXbvVPIp8QeC
 URILt49gCzJYX4T+L2OoMZ3zTJYFzE3/xc4HVfjfWaG62jthM++PRtCEaOXf0YVMQ/SQfdbWK
 4eMUBk5O84uFasXEC94mv6eA09DK8yy7+le79ke5FT/kW7s0HjSNNLI3H/TbDe3ociqpb+Es5
 FnRqwrd5Xrl7LdMp5TWuqNG2L3y/AE+87klNwIVaS4Ltg9EYakUyNAB1uUtvfhsu8aqL6VB3n
 aoxMjFfqhgoPNEHjywQysX69Vn7OQ4UGPFJDbVYFBciRzrFKUK5lgUq26io=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.19 16:42, Sven Van Asbroeck wrote:

Hi,

> Fieldbus device (client) adapters allow data exchange with a PLC aka.
> "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)

AFAIK, "fieldbus" is a bit broader term than just the typical IEC61158-
style remote memory stuff. At least that's the terminology my clients
tend to use (eg. they also call some homebbrewn rs485-based protocols
"fieldbus").

Maybe it would be better calling it "IEC-61158" instead of "fieldbus" ?


By the way: can this device be opened/used by several processes
simultaniously ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
