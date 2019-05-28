Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A2BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1039121670
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OudzPpmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfE1Vjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:39:52 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:62587 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfE1Vjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:39:51 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-10.nifty.com with ESMTP id x4SLUJQh023691
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:30:20 +0900
Received: from smtp.Nifty.com ([223.187.238.67]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4SLSBPT005803;
        Wed, 29 May 2019 06:28:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4SLSBPT005803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559078905;
        bh=HNCqjlyooofLVUnnZLKXIgkVej1rwYGi4yCNuTDazsM=;
        h=From:Subject:Date:To:From;
        b=OudzPpmcciYNeWI47WrJOibSKnNz8HZSX4yeB+hMtDEcWR0wizDetUq0yF7f3L7e3
         ZR/f8c9thYIfjQgNVRwtgsHug5BM6O3nrHVPkl0K2QiU2cHO+V5jsvkNPVC4JJX2cP
         aityfKZ7MfMrknKKUVPzb38IuFw9pX9ssKqFLtGoUxOJ6kNSjfvgIoKeQRLQNvo8m7
         jSsbKvuk9+ZyauRXcPpISXP4pXlLoxuIyLq+dQ6qhPYEmQMr+C4lcbwMzVgfQ/ybeB
         NkLu4KBhRkAfH/Vs/QU5kjZEC24R4aBpRv8C2CsT/IfC2BDAZhgEF8C4DDRIK7nao6
         PhVmq7yGKRadg==
X-Nifty-SrcIP: [223.187.238.67]
From:   Venkat Subbiah <yqb04710@nifty.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: hello
Message-Id: <CDB0E14F-8902-41A5-BC4E-F230C00CA44B@nifty.com>
Date:   Tue, 28 May 2019 13:31:29 -0800
To:     "linux kernel" <linux-kernel@vger.kernel.org>,
        "Macha" <macha@yahoogroups.com>, "Jay" <jay@anisi.com>,
        "Usha" <spemm@g1440.com>,
        "Ravi R" <Ravi.R.Mallampally@constellation.com>,
        "Ravi" <ravi.r.mallampally@bge.com>,
        "mangunathgk" <mangunathgk@inf.com>,
        "Ralene" <RMARCOCC@altera.com>,
        "mardin amiri" <mardin.amiri@regus.com>,
        "Ed" <Ed.Martini@caviumnetworks.com>,
        "Mayur" <h_mayur@mailcity.com>, "K" <k_murali@lurgi.de>,
        "Prasad" <prasadn@cs.tamu.edu>,
        "Narasimha" <narasimha.km@philips.com>,
        "nely rojas" <nely.rojas@xilient.com>
X-Mailer: iPhone Mail (14D27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0D=0AGood afternoon linux=0D=0A=0D=0A=0D=0A=0D=
=0Ahttp://alexandrastanciu.com/chapter.php?sykegp=3DVLZ19401=0D=0A=0D=0A=0D=
=0A=0D=0ABests=0D=0AVenkat
