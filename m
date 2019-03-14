Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C549C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E612184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfCNWe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:34:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39521 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfCNWe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:34:57 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MkprN-1gcgkx0B6F-00mMZ9; Thu, 14 Mar 2019 23:34:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: serial driver cleanups v2
Date:   Thu, 14 Mar 2019 23:33:30 +0100
Message-Id: <1552602855-26086-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:90tVeR9OdExxrSMvPUryTzfPCWjO8NamvaYvMWrJ8sQIo2vkZEM
 WLfgLJ9+jnh45Nf7Rjk9Tl4let5oIzu8P51lsevr4kOSsznnoLWWfQMnWxa3mARd8SuRsii
 BK8WPgu6oeerNXMtTkzb8jp1TSgOmpU7uIED+Hd1FY/kAVTztF3wNFRAjZG841vMctQZ19Z
 NU+pfZA+a457drDVUdIlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CkT95SOkLIk=:XQtGzRuMeTpqtd+Vvcx9sW
 2qSnUPEWCO8ddfUL5eO8e1KDKYrpveInu88Sp48xoZfKPYM8tUPqrJPiyZASoyIXAFSmSpgeM
 BesEw7d2yj9hWe3/VhZAAp6oUKNekUvxm7RqoV5b3yim1yNo3yG5Qx9DShS5d91Sf48Jzf7qS
 LT+85wtn0iyIkjDidz9lLqco18b0rW8rjiBNV/6iYf1r9tl0KAOGbqwFEmQDYKqJWqL3W/hCS
 R9uPF0dYkWxkuhhWuFthZTbu6J8QrRN1hnHVYmItReql2WWPRFFI4NL9ihgAcGW0DD2yjVZUs
 VELFRgSgbh0mkfmjgNvGabhNgg02jKDusV/1CRiviaeZsmM7cmujZ0nMIWHb6+9qubho1s+T+
 Spt4e+fk+NggtbsKU9qkL6T8MQPH6bZc5ghHCz9bDHakEB93J/wZonWhZkG0A+moPEpvG+lwD
 7lSXxiV36sqUSI6s0NbyQVarzKRxwQmzRAnu4KQsW2c4UlL1sW3ZhLeBSzUBHRzrdCN3SkMBf
 gfqQJfEirx3CakxKDwtyoiDerq04m8flE3GIjnxBGTTLZIgX/fz5F48imtkb87R6KBuGvVAsw
 XOpXPnGxcrao0jIADgOnjqWLjDMk9rb97iXFeU/Fii+6uAGNbwLJCkTHqpIYR5gfAzh7c6vuP
 DiIIyU9v45qnCKmCE+W/ltm3BjyUxpXPnjN9kcX1fcJzinrmouP7FkvI6iC6Mh13sm48y5Na5
 4E9ts9008+/7hUxpRaxm0wK73N+dn09Zm0G+Wg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


here's v2 of my serial cleanups queue - part I:

essentially using helpers to code more compact and switching to
devm_*() functions for mmio management.

Part II will be about moving the mmio range from mapbase and
mapsize (which are used quite inconsistently) to a struct resource
and using helpers for that. But this one isn't finished yet.
(if somebody likes to have a look at it, I can send it, too)


happy hacking


--mtx



