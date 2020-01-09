Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CCFC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71073206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgAIIiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:38:04 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:50605 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgAIIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:38:04 -0500
Received: from localhost ([31.212.60.142]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmkfQ-1jVdqE3mre-00juHp; Thu, 09 Jan 2020 09:37:49 +0100
Date:   Thu, 9 Jan 2020 09:37:47 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: srf04: add support for power management
Message-ID: <20200109083745.GA5355@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:taFnjaQNKRBcxh5H1aI/Wu0h2rIuWWnXiK4+hRD/o9IOhKPMUG0
 CwisHIEb6ZgyXLFBu3EFQThoR+Nj88VIZ5Ls9qLRgJj0qNPgL8JBQII8NR5xwmZb+2uCxg8
 AwYdTK1P3h2Mp02iUL6ybWrtQ4O+bzbkLG+gpNSNlyHGRhmj6scyqHSQ8tvKM89VLSe4FJY
 2SkZMaQ9rtWgDEKS/aBwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lqokbqj0kWI=:u6UkQGAZDuBtCIZ6xY91ce
 e+P2wkA7L4o4vcr/raqLmM/Rlu3BmRxnq2pPoNL7drMh1YVcn13RAoNap1NqZqFBX4Rt1r5CY
 5WUffRUAfwT/430wqXmD4sUKZquxRXcamics00Dzzz2WEws/UdAcn5AfSPHuFfdDUTdoGr/Lb
 5VOrVjPk7AeofTOzBQkJDhongWM/9NIt3baLUX7gw4tHRXURVzCt465pQeQblwgzuu5jyzw2e
 b4B/Q6hCpNegrGUybUg7IOxF07tKGhneHdNCjjakRUD/sJy09QmeNDnsmShmjbR3BfdU8m0+h
 p6gTO91eJ1jIMpoEnZG6uli3UGlYp+9JjjcBPEaIVBKToUQzW7L+472WzRRdhsfSfsmudFzQv
 kFKvfdpVbSFXSlC5jqnv/GgzJsSIA4fnTOwCn+blmA0v7HsbuDSqmJbIw0QkTFLMcgmZCm+h4
 a873SDhkAoCUDvejvEzixyxAdVyTEfzIpgS5yCceP0q+K25BaNL9U2HtBIdt/furyeTeHJAx8
 IpxpJRovzgNmv45zxNfrEBHjHv27wYWJVBt1FJo0H+RwmPIE9/FDyavnsSMg31aCqeZ5jYGye
 j8l13H3weG1ZnP0rhbvuFYTb18BIR2B5z8KafCagEx+YvTUA0dqzlkX1tns74VSEjntZXp9qK
 1Iu6FRWLMXq4X3fhYYqug4jxzUbbUsu7vEsHvumHWw6yZcx/RXidykp02rD+zdQC0TpDJ0QUG
 BOhB+x5ig4smcrmrTmNpTgXmqo6groSeN+hVladKbMugI024aVpuB/5nNwbfJCZm0scWeA+oL
 I9SwugfFWW7GzORXOZxixRiW6CPV+DkdD3hR+wfBIPeriLgZQBIGjGhGEqg49jDix79Jiz8J6
 7xlI5sllc8CiaHlROgGA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for power management for the srf04 iio driver.
It was suggested by Franz for the purpose of saving energy on battery driven
vehicles.

Changes in v2:
Thanks to Rob for pointing out some improvements in dt-binding:
 - add minimum, maximum and default value for startup-time-ms
 - drop schema reference

Andreas Klinger (2):
  dt-bindings: devantech-srf04.yaml: add pm feature
  iio: srf04: add power management feature

 .../iio/proximity/devantech-srf04.yaml        |  18 +++
 drivers/iio/proximity/srf04.c                 | 104 +++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.20.1
