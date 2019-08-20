Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C9DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7737422D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="NXUakd2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfHTNF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:05:57 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:49355 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729409AbfHTNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:05:57 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46CWJ34NYVz8sjr;
        Tue, 20 Aug 2019 15:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1566306355; bh=lb8pMLWA/VA/oL8CbcSlxfZ+6JeFEBrMTYhrB9/suCA=;
        h=To:Cc:From:Subject:Date:From:To:CC:Subject;
        b=NXUakd2IyjOlE3JnEV3Yc7SFtAdJ1Y0bNnbyhyK/PGXO/7PU1+efzFb8Kuk21vgOb
         D6PhS6WSR931DmelosVdSo+02ZO2P/x6vaoGUKRuPTUQLYwnp9XjTWd96o/nPxIxo/
         sFkZUZCLIUJzBXZlO1BjZkVi9PgaRd13U6xRMBqHCiuL4hyEvmb1MCJd2hYYOIwRLT
         YDvONzD2kREv5wWEyhLdwhCqNMbtRrhoXyyyaI/7v3zUSfLyTFUxcG9J7ohRqSAP6e
         m9/Bi1dDv+Uor+opPUE0FM0yedhpM+mU+WRl6AxqKHaIX+6PXhPoONYNAFLPiVgL4M
         vSeTpw5pl0KZQ==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 109.41.192.99
Received: from [192.168.43.238] (ip-109-41-192-99.web.vodafone.de [109.41.192.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+X1yYeybKyPqVRxG0em6iZ4Kh6m7OwgWs=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46CWJ11GYxz8smp;
        Tue, 20 Aug 2019 15:05:53 +0200 (CEST)
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
From:   Sebastian Duda <sebastian.duda@fau.de>
Subject: Status of Subsystems
Message-ID: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
Date:   Tue, 20 Aug 2019 15:05:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

in my master thesis, I'm using the association of subsystems to 
maintainers/reviewers and its status given in the MAINTAINERS file.
During the research I noticed that there are several subsystems without 
a status in the maintainers file. One of them is the subsystem `ALPS 
PS/2 TOUCHPAD DRIVER` where you're mentioned as reviewer.

Is it intended not to mention a status for your subsystems?
What is the current status of these systems?

Kind regards
Sebastian Duda
