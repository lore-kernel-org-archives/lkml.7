Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF3DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C99A20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="NfXujEP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfDJPt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:49:58 -0400
Received: from a9-34.smtp-out.amazonses.com ([54.240.9.34]:56520 "EHLO
        a9-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728826AbfDJPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554911397;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=0XwwQPRGaw7KgTDhnUmgjcd43E3sjloMv0Xkja5uBiE=;
        b=NfXujEP7h7+awlKKkWFlPto3lUIHLNPSEeH2fpwtFZJcm19WAbmiVRddnWr/diGu
        yC1Gt9xkJAb1CccRjBG/XUMEfA3vxkczeUiODt/eDSJdm3J+TP7iNelFVdGYmF9IGei
        M1M7ccKjDXShc0ywiZsxsnfUx0pfoTPzdYkNiO8U=
Date:   Wed, 10 Apr 2019 15:49:57 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [External] Re: Basics : Memory Configuration
In-Reply-To: <SG2PR02MB30989B644196598CEDDD5337E82E0@SG2PR02MB3098.apcprd02.prod.outlook.com>
Message-ID: <0100016a07f105bf-7e1f2eda-fffe-4418-9b7e-9f6572e08633-000000@email.amazonses.com>
References: <SG2PR02MB3098925678D8D40B683E10E2E82D0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<0100016a02d5038e-2e436033-7726-4d2a-b29d-d3dbc4c66637-000000@email.amazonses.com> <SG2PR02MB30989B644196598CEDDD5337E82E0@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.10-54.240.9.34
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please respond to my comments in the way that everyone else communicates
here. I cannot distinguish what you said from what I said before.
