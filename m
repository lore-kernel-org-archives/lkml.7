Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B291C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E9520821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfDPT5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:57:42 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:57:42 -0400
Received: from orion.localdomain ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MHX7f-1h3VdV030b-00DZ74; Tue, 16 Apr 2019 21:57:40 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: gpio-keys-polled improvements
Date:   Tue, 16 Apr 2019 21:57:21 +0200
Message-Id: <1555444645-15156-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:y8pXtIZrV/BFI6G3ZUwD+N0UOg5NJYEoB/pSYKYCEG9f68cD7ZT
 wfb5q18+vcINXWoN3ihp+P8+wOQyBH69lkVC5A8IZuQhy9Fw8gsewqTpzswaBPibzNdvR0y
 uKxtqjD3unkqm4z8rzOb9mycujf2tdFhmERx87ruRSdo6TybtMZi3SiN0ajdBSwxE8VsYIT
 fgLkONncum4KYTecPSfpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KR00CaChhWI=:qSDYlkMDI7L/+ilYcUY83Y
 VCbl/5vBVHRh1/ib/97zkRd7ijvLQHWISY7i+zCOOz+IpQQAptxyIjlN/FJ438/EuDnwrX/NB
 Vm4FmHvb5Ug4iiP+x1vx4yKSWL0ONfj5TaGYwvnwuXYWm7B91Te9p8xciGCxj2jcpkSdYF6Dx
 4A5RUMaGaZiMmysFB/QG/bfyxzRi0NWtYgf0dN6cDh6BvCHLysPZlNz/X+vA+dUQz3LYOeUwl
 gK4vGC9L2fzENa5dSym6fJupeALtJy00XPLlsMb/1+71PkuE0uT9iYhsoX5KufsMuisOqAopl
 MbJgaARIar9cqtui7G49CwIfUwynl8nA40IV71tnAcoTstfzEMsoxJUTfTKvXUz52jk9wzA0/
 tAJRN+JQYOHhWDHyg81HBcQa13gOTRHzPFJb7Ct9j8h8Nq7BwY6VE5rhhz2jvewAJUyjqty0X
 xf0reVW+yMRscwA7kbRiM+fGFcpp23udVTPC1MEgBDjdMjJtoR2Nm0AjQtXYoHJYtWXq/hEHa
 DS5MnYmHidxKXE9zClErRdZLlD2UyctAFiushpcTUzqBN3odsQtpY2cGD5tE4DaDVd4um+ifk
 Xe3ZocNHXrhlsAlfynO98t0ifbO+TMSXLIca/0Q8dxlt4ZkNdLUKdQUzVmmdxz3PTbBhrKA6h
 RAX8xY52+qRcvszfEHWBy8dtOuj+6ENG7fSuYTYGRxj+iNDrbY9yaZWfYjbPTXtMeKb2pc2mY
 e7AG5oPEon7g5AFWBQTFWAgUp0rZuj8+UBe8Rw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


here're some improvements for the gpio-keys-polled driver.

The first patch isn't in the driver itself, but adds a little module helper
for conditionally declaring oftree module table if oftree is enabled
(only needed for the last patch)


have fun.

--mtx

