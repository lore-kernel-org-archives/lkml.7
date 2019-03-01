Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F512070B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCATf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:35:28 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfCATf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:35:27 -0500
Received: from oxbaltgw03.schlund.de ([172.19.246.9]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQ5nK-1gdtKb2N4C-00M7AQ; Fri, 01 Mar 2019 20:35:13 +0100
Date:   Fri, 1 Mar 2019 20:35:12 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Andre.Przywara@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org
Message-ID: <1128468323.249298.1551468912168@email.ionos.de>
In-Reply-To: <20190227010544.597579-1-jeremy.linton@arm.com>
References: <20190227010544.597579-1-jeremy.linton@arm.com>
Subject: Re: [PATCH v5 00/10] arm64: add system vulnerability sysfs entries
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev51
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:cFZeMU6t0C89EyrHq1lpmK9AVdWLlKxLPmIJggD0nsae2UG4H+2
 dR9SnoMJduGyv1mGA2VrvexjtPY/PA3Z/SgnttjYfGT98v8fTqhSWH+Ba71QfHHUsP6ZF1j
 OJ7JlpW2qREao43gCryhpz/iwkQrhD0l38M0hf5nexGwZvjnt2HQzWz1VS4msz1WeyLqzeM
 1oov1i3k/h8GKnvbLuDqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vZY9wyvEh2Q=:Tqw/FQELb4IaUHqUNX8FJC
 L8RfmrUSxuZJzHQSawaH/V/PD7VZVJsAppr/UOTmmh1epfcsDyuoNEwNzY3rSgNnGvCw2BXQ8
 9u5R8FMK+Bx6fPE3dulSalMBPe+pgoow1WHtRCJspc8L3eoqJK4RjtP32V6vMHYyuqt2r4P6+
 YCC0FbWR7nj5aGLRg/5MmlqMr5LsIVjSx5LY84zyvqdvSMq/8sTPV3K8UjdaSZRigs6Kn2Zcb
 ZcbS5iN7YS4W6WUpfhoindLCw636JftjDTLq9zRnDURR0xxcoaFA48Zd1fVaeBeFYya7Z7pfc
 5nin40VIdMgcMEM4qaEXic/omci9dtQX8mVWPwWlcMRUj8Xp2TRoJNeMsrzw2amSHppZgVaR7
 lwUh2gliXP2paToKXa/d4LLgxhR8Fe6rNIo97FRGxH1+Dxsm9RiqD59aiAHDcVZkFLQveWAH/
 42CHp36i6s45rh/LMO9blQFy1vZJZRqj+ocw89SwpjHEhjXCuSB4eRcEIP+o4P9E2bRr5dtwb
 PqMzAhIxvKAdjq81VKvlZ+vzyAQoZ72aT49OIzQgqDXeu0Umhb/2DI9ghoFjCEJtShhaOYo98
 JksCbcSmqSlo8wgTSqjAxo8Uwmp4B6la8h66mjfdkLcDRQ2517sdcuuhES6HqYRYjOQdIjtLq
 p20wFmZIgnQoGy7OVkLFGj38zPysBqnfm+0MunewjgvQKSb3fMjoLTmNP/qk2nd65ZaBI7GkH
 kgKxEAX4UCupmE2keIjPDDaSSOgPcQsWbyymi4sqoeivASvT0B64ALwDFtw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

> Jeremy Linton <jeremy.linton@arm.com> hat am 27. Februar 2019 um 02:05 geschrieben:
> 
> 
> Arm64 machines should be displaying a human readable
> vulnerability status to speculative execution attacks in
> /sys/devices/system/cpu/vulnerabilities 
> 
> This series enables that behavior by providing the expected
> functions. Those functions expose the cpu errata and feature
> states, as well as whether firmware is responding appropriately
> to display the overall machine status. This means that in a
> heterogeneous machine we will only claim the machine is mitigated
> or safe if we are confident all booted cores are safe or
> mitigated.
> 

here are the results for Raspberry Pi 3 B:

l1tf:Not affected
meltdown:Not affected
spec_store_bypass:Not affected
spectre_v1:Mitigation: __user pointer sanitization
spectre_v2:Not affected

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
