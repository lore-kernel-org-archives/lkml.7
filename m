Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E47C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3222075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfFELgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:36:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43193 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfFELgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:36:33 -0400
Received: from orion.localdomain ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5fUy-1hVkO50tkQ-007E7G; Wed, 05 Jun 2019 13:36:31 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org
Subject: libata: sysctl knob for enabling tpm/opal at runtime
Date:   Wed,  5 Jun 2019 13:36:25 +0200
Message-Id: <1559734587-32596-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:7l/7tU0oDKofwSJ0uC7B/rDVpD8uitWVNS3x/ROwPlktyTzjyeC
 2jR6R6HBplxSUkNi+/6aTP2e33QyJm41FtDIqNy4tbDBbnkazuroT3/lVHUTMDMvjWMMTxE
 aQ8PRTs3VJpJsMYxFPdmqz01LUrdV2AI93ccOKlXBuJfmXZ1wVYwFokw35nxgmvtVf8tl0g
 jItR/HGtZljSzFm2M37iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ioRq9iBXQ40=:gu6171N8ZufAc59/v81t3O
 aCj8YnKjc1Ab0r/1EcC7/sq2PthhtkLHwOltxE59R4GwfYKUir8DGoSW+oBVbQutP7h8eLJGW
 RfxQzEFC9leD3K/NDjnDrpmVrV6W8QLE7oAcAubScMEcMwURoja+/18iFPpNKoFkm+UUzipOY
 J/IAa8sP1vk9wSY4fZ6S/J3iNDMzbi0xb2OAlIORv+q3fUSWKMfQs99LLSd26j/EvPF7QbFK1
 MdG26GhcNQWYuXDwUUU5qyokI8XA4iHya+lOln3QQUNfi4KiM3OApovujDDza4XToxrHpJyjN
 LfCZKLww4cq86T67EwWrlITv2Zc9XWneG+DApOAcXY8HzoRs1Anj1u0741wroEyTFnxUua8vh
 dt+D0EP0nqedBzyMlQuFzOncx1otusIg5ExR4EocJ9mhKDQUooAsGuEBYyVuGvVmcyHlSJZGa
 zLG2bYqRgaAxUrvRDTj/gdqYF+F/YRuo/R84Z9vssYsdUgSuKQstUmOkvEijx9lYn9Rfl7EGm
 O8OfJnzDTntz5jd8R9wvKODLmg+Clj+brnhk1Jn8YMlbJZ2PGFJBRko6Mky3Zi6XQUdO//43I
 38MP87UsrUg16oAMRiJIX+QYny869yFa3jVFNt9OgTG4crZJibtNiC3Jdg+xSiHsyWcrxrVOO
 PlN403NqvlQ/xPSxHGov6sFMPqBQSSRSbWUIrm2vC/smt83nFfcrwuvcB4P8LZbf8CNPLm26K
 KHbI1NAOBx4UPUOk51MddSCvZP9Nu8suPV4leg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


here's a patchset that allows enabling libata's tpm features (opal)
at runtime. Until now we need to boot with special kernel parameter,
in order to use OPAL - this patch also adds a sysctl knob for that.

It seems such a knob already had existed once (perhaps just in an
wip patchset), as sed-util expects it.

The first patch just introduces a systcl subdir for libata, the
second one adds the actual knob. I had already sent these patches,
few weeks ago, along with some general build fixes. The latter
meanwhile went mainline, but haven't received any comments on
the two opal related ones yet.

Please let me know, whether there's anything wrong w/ it.


have fun,
--mtx

