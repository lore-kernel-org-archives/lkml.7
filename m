Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76917C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF4B206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfHBEXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 00:23:43 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:50045 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728157AbfHBEXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:23:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AD9EA837F24D;
        Fri,  2 Aug 2019 04:23:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plot37_7776b4afd1f61
X-Filterd-Recvd-Size: 1675
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Aug 2019 04:23:40 +0000 (UTC)
Message-ID: <7a06b8e9acf87a871642166370ac50ec6c734ce8.camel@perches.com>
Subject: linux kernel sources: more misspellings/tyops of <foo>iton words
From:   Joe Perches <joe@perches.com>
To:     kernel-janitors <kernel-janitors@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>
Date:   Thu, 01 Aug 2019 21:23:39 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If any feels like it, here are some more typos from:

$ git grep -P '\b\w+itons?' | grep -ohP '\b\w+itons?' | sort | uniq -c | sort -rn
      7 additon
      6 definitons
      5 Prediciton
      5 instruciton
      4 conditon
      3 partititon
      3 notificaiton
      3 implementaiton
      3 definiton
      3 Additon
      2 veriton
      2 unconditon
      2 poriton
      2 parititon
      2 initializaiton
      2 defininitons
      2 conneciton
      2 configuraiton
      1 translaiton
      1 Transisitons
      1 traditon
      1 quesiton
      1 positon
      1 posiiton
      1 partiton
      1 moniton
      1 inspeciton
      1 infomraiton
      1 implicaitons
      1 identificaiton
      1 generaiton
      1 encrypiton
      1 destinaiton
      1 declariton
      1 confirmaiton
      1 Configuraiton
      1 conditons
      1 calculaiton
      1 applicaiton
      1 allocaiton


