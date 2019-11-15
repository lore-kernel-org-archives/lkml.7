Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84BBC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB8320733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKOJdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:33:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:44295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfKOJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:33:49 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1My2pz-1hfdsh0DyZ-00zV17; Fri, 15 Nov 2019 10:33:48 +0100
Received: by mail-qk1-f170.google.com with SMTP id d13so7589673qko.3;
        Fri, 15 Nov 2019 01:33:47 -0800 (PST)
X-Gm-Message-State: APjAAAXS/EV5BsFcJFwN5VESTmD3xzK1lo4Tpyx3tZDu3ZV4vc/th8Iq
        tbAJcCQrU1iJ+99PiZZyUU0NGuiczPNXYO+vloI=
X-Google-Smtp-Source: APXvYqyHs9ad/+3HaWdqKuzJptVRHCVwDklMrgq5Mkioy7i8IrZPX+/M8dSz9o3BBSnMlS0BE9d05Ry9BXPIzZIB7/k=
X-Received: by 2002:a37:58d:: with SMTP id 135mr11660269qkf.394.1573810426879;
 Fri, 15 Nov 2019 01:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20191114114525.12675-1-orson.zhai@unisoc.com> <20191114114525.12675-2-orson.zhai@unisoc.com>
In-Reply-To: <20191114114525.12675-2-orson.zhai@unisoc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Nov 2019 10:33:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a23jcNgFErik1PFr=tG6n8kc8Pj9fARw47n=ou8t8iV+Q@mail.gmail.com>
Message-ID: <CAK8P3a23jcNgFErik1PFr=tG6n8kc8Pj9fARw47n=ou8t8iV+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add syscon-names support
To:     Orson Zhai <orson.zhai@unisoc.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        steven.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eAMMgYvcgQoIgeVOJdJnUY/zP11VckfLtwFUG99sJIU8dAsgB97
 u+/vqG/j8y5hJiZP05FZJmsBaHHVRdgp9Q2pj1HvCU31AbH3QMzT8Obj4hvoDVfdDciCdb7
 q1RpMPtr/0FgtjxpBbA/2vqCJnA9sos/rT3tomqcs9pcjTXG0WfEja+K5ZeeLJkDfxvL40O
 4KgiVz2t3zMISXv1BBgjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3zhn3xOu5SQ=:XN5QE8YqU9AxAkLLOGzELj
 4WN0CHJacEG2b4cF2W6VXmxgTitnHkllDhz/1eu+tPDjFN1BiN8Nuihcf8qpksrRt+S1CNNqx
 5+PK+riuhCsyA68T9d0c8d+0pA3cPwMLn/TWTBNa6VdTRjbsUMBf1dtKMB7XgMh4iiOna2DG8
 yxqPyk3FUt8YgMjezbKmtrRR/cds8G1YukNhPCrqUyBr3dq1GXpJCMh+g41OC9rv4dL4Oak82
 oTHaNfmY2QBks8HF1Om7CIYdX7flDfflMqxrHV+MHjGQIkyvL9TKkXqSzVFFZNmVQVpLJDhEK
 hvYm0Twf3eVvtBnZRPasrmTXIJtrDrqQb5kZq1I2kvT0vAWHK+kwwoF6tNrAsvEMbgcEVDklA
 TfiDaBh/evD6CTycBB5CPhPXFAWa0sT/E06l9HGTjvFe6yEdbf/k4yG7YfqNZJX8oTpjY0T4A
 /2B+fokO01pGeOuN+VmpqTWsQ101KCMRBRAiHrihbFHNqukh2+sBb+SfePfYycjC3rZyDJhiB
 oLzUEABLr64u9YOx5qvU1BYqGru4ywTTgaVXBlf1tcc0YugZSrMG98zz6YuEBTEYYvtE7pNpe
 0EFU9P5YUe9mG2wwOpV2tccUHirhRnPYIVgKoemx0UEuX2E0/znFTM1jFiPU/YGbEFKu9IsSL
 8OEDh7cX0xAXLNStwMlsgrnnxRML7VSfEjDoLL4ytIgoTCR+cYbHwkf1m1BlJo4sX5iixltLk
 As5QXXSM5aiqufpyOCg8IPNMt80iHkHckfk9uijT1jHMB42DgANNavX9Z/Y9g6Mg9i27mWYs7
 +jINjnKPIBskDGPI20MYah/jEqecwbmrzPVefrpl0QO+V95Z74TPPaKppM43UDs3j8PZPL0zs
 vVCdoq8csaWrQQhrVJeA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 12:48 PM Orson Zhai <orson.zhai@unisoc.com> wrote:
>
>
> Make life easier when syscon consumer want to access multiple syscon
> nodes.
> Add syscon-names and relative properties to help manage complicated
> cases when accessing more one syscon node.
>
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>

Hi Orson,

Can you explain why the number of cells in this binding is specific
to the syscon node rather than the node referencing it?

In most other bindings that follow the same scheme, the additional
arguments are interpreted by the subsystem that is being referenced,
but the syscon driver is just a simple driver with no subsystem and no
code to interpret those arguments.

The way would otherwise handle the example from your binding
would be with two separate properties in the display node, like

syscon-enable = <&ap_apb_regs 0x4 0xf00>;
syscon-power = <&aon_regs 0x8>;

in which case, the syscon driver does not need to know anything
about how it's being used, and the display driver is the one making
sense of the arguments according to its own binding.

I assume you have some good reason for introducing the other
approach, but I don't understand it from your submission.

       Arnd
