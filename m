Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D46C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715F22089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEAUdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:33:12 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfEAUdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:33:11 -0400
Received: from excalibur.cnev.de ([213.196.200.188]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXYAj-1hGI2t16Yp-00Yxxl; Wed, 01 May 2019 22:32:52 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1hLvuK-0000JY-Jd; Wed, 01 May 2019 22:32:48 +0200
Date:   Wed, 1 May 2019 22:32:48 +0200
From:   Karsten Merker <merker@debian.org>
To:     Anup Patel <anup@brainfault.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zong@andestech.com" <zong@andestech.com>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Cc:     Karsten Merker <merker@debian.org>
Subject: Re: [PATCH] RISC-V: Add an Image header that boot loader can parse.
Message-ID: <20190501203248.oadcldefusc2ighv@excalibur.cnev.de>
References: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
 <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com>
 <20190501170053.GG11740@lakrids.cambridge.arm.com>
 <CAAhSdy2OuCb6wBrs-O=fTWo0D_CgwTztfV-kMDi=tPmSJhM7og@mail.gmail.com>
 <20190501195443.trgjv6tujctsw5sw@excalibur.cnev.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501195443.trgjv6tujctsw5sw@excalibur.cnev.de>
X-No-Archive: yes
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:uAFOUbMAST/fg63gGkCxdt/hO21IE0Vf8MY/Ms1ItZjbUKKeRaM
 X3ziOi00VTr0wfRTUPku62LmNHlcdHKpp8aqgEypwoZwWgBcyZgLKum6sg6yZZpAK2dOxAc
 nF/rWnvuGYeP4ket1h/vVRh8ElovIybmZuVDHzPAPHGE+Zn9C3lM76BMHWkWc2BABa8CABQ
 ELwBTDw9ewm1qd8ZngyVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xhj0qQJdr/8=:2CTkHkDNXsJsE4iCWO5dGZ
 BsdK0s641viw46BVtn9Dn7tnCjRB48pPsqevSrPPzLTeLheVoKH6VVF8X3wbe/e1A5ADPY9uO
 F6kxiXkfJX1u7wUzI597bik0oD1Q4T/a6Qo4LbYvhjVsANX4Aay1V6hcz1/N/Yejed1ZvFMH8
 gpDywyK0iMhAksuE+lUEgPLjFcG8fqzbQmIE3qOPiuS0Srla/w7dPJ0TXMjph93xBTEN0ZijW
 2lRM7b+BsgW9WVdFUC0ioivjHcBGIrC8vNySgjo6rHLxhYncQTfmvBja0pUH8J9tAvDA8OY19
 7KJsHZz5s3UTmOMFOW9jpRiE+OIsA3IMXsFfq1nFTrnRZEV3b99AKPwLWCHH1JUulK7p21ZzV
 TEz4H5nyNf0jUXz6gjTNWKsqJsU8G8IeS6EySdb54WqQDYq8/MKDlpt5lAp7Qfj6JXqH9w7yj
 qLshvo0KwBP71aG520MA0qEEzpapm4NbVWiN7WctYsFYQ6JsItWMePn4ID+RLYlCIR2+strG2
 dDs6pJ0q93Q0Ia/2YjdVXQEj9cwC6RFNIdHpzGi0jZAHglLq/EwPElhMGz08TRhC/Fzf7jT6X
 klVMmo5fb8OClfps8V362x74R1UfFYz+fIrz3D9jNf5WfsXwJuHPJwyH8n2krzTYv48l7HUIH
 tIUCrLxPPYdvbFaHQPFOK9sPl3QZalaSyUKXBIAZlYfWagXnKHtzhua6/sP0gz5oT129h8mdp
 8AcIxS/Q3pD5ibzIBUCx4wuddq+8jLpnvlSC9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 09:54:43PM +0200, Karsten Merker wrote:
> On Wed, May 01, 2019 at 10:41:52PM +0530, Anup Patel wrote:
> > On Wed, May 1, 2019 at 10:30 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Mon, Apr 29, 2019 at 10:42:40PM -0700, Atish Patra wrote:
> > > > On 4/29/19 4:40 PM, Palmer Dabbelt wrote:
> > > > > On Tue, 23 Apr 2019 16:25:06 PDT (-0700), atish.patra@wdc.com wrote:

> Probably I'm missing something obvious, but I cannot completely
> follow you here. My understanding is as follows:
[...]
> If the first byte in a PE/COFF header has to be an ASCII "M",
> that is 01001101 in binary.  RISC-V is little-endian and the last
> two bits of the lowest-value byte define the type of instruction. 
> According to the chapter "Base Instruction-Length Encoding" in
> the RISC-V ISA spec everything except 11 as the lowest bits
> denotes a compressed instruction and if I have puzzeled together
> the the various instruction bits correctly, ASCII "MZ" would be
> excuted as a compressed load immediate to x9/s1, wouldn't it?

Sorry, I have misinterpreted a bitfield in the spec, it's indeed
a compressed load immediate to x20/s4.

Regards,
Karsten
-- 
Ich widerspreche hiermit ausdrücklich der Nutzung sowie der
Weitergabe meiner personenbezogenen Daten für Zwecke der Werbung
sowie der Markt- oder Meinungsforschung.
