Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA55C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 13:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830FD218D0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 13:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfDGN40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 09:56:26 -0400
Received: from serv108.segi.ulg.ac.be ([139.165.32.111]:33261 "EHLO
        serv108.segi.ulg.ac.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDGN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 09:56:26 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Apr 2019 09:56:25 EDT
Received: from mbx12-zne.ulg.ac.be (serv470.segi.ulg.ac.be [139.165.32.199])
        by serv108.segi.ulg.ac.be (Postfix) with ESMTP id 9C493200DB85
        for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2019 15:49:10 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mbx12-zne.ulg.ac.be (Postfix) with ESMTP id 8FE3F129EA99
        for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2019 15:49:10 +0200 (CEST)
Received: from mbx12-zne.ulg.ac.be ([127.0.0.1])
        by localhost (mbx12-zne.ulg.ac.be [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TT6UgZEE1weJ for <linux-kernel@vger.kernel.org>;
        Sun,  7 Apr 2019 15:49:10 +0200 (CEST)
Received: from mbx12-zne.ulg.ac.be (mbx12-zne.ulg.ac.be [139.165.32.199])
        by mbx12-zne.ulg.ac.be (Postfix) with ESMTP id 7658A129E539
        for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2019 15:49:10 +0200 (CEST)
Date:   Sun, 7 Apr 2019 15:49:10 +0200 (CEST)
From:   Justin Iurman <justin.iurman@uliege.be>
Reply-To: Justin Iurman <justin.iurman@uliege.be>
To:     linux-kernel@vger.kernel.org
Message-ID: <937711609.49388.1554644950383.JavaMail.zimbra@uliege.be>
Subject: Multi-threaded packet parsing ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [87.64.170.237]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF66 (Linux)/8.8.11_GA_3787)
Thread-Index: gndnIChOVn4ZBg76CUG4k8XIhrnayA==
Thread-Topic: Multi-threaded packet parsing ?
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Currently working inside IPv6 on EH and more specifically on hop-by-hop's. I was wondering if packet processing/parsing is multi-threaded or not ? Actually, I want to store per-packet EH information on net_device struct, which would be only valid for current packet processed/parsed by the dev. The goal is to take advantage of the existing parsing to store important info, which would avoid useless duplicate jobs right after the processing of EH. It should be fine if it's not multi-threaded, which is not ASAIK but just wanted to make sure. Can you confirm/infirm ?

Thanks,
Justin
