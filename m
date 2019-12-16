Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147A9C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8C8206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfLPNwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:52:44 -0500
Received: from uidappmx01.nottingham.ac.uk ([128.243.43.124]:54275 "EHLO
        uidappmx01.nottingham.ac.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727984AbfLPNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:52:43 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 08:52:42 EST
Received: from uidappmx01.nottingham.ac.uk (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id B0A543C464F_DF78AE4B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:47:16 +0000 (GMT)
Received: from smtp4.nottingham.ac.uk (smtp4.nottingham.ac.uk [128.243.220.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by uidappmx01.nottingham.ac.uk (Sophos Email Appliance) with ESMTPS id 7CA343D412A_DF78AE4F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:47:16 +0000 (GMT)
Received: from celebrex.eee.nottingham.ac.uk ([128.243.74.16])
        by smtp4.nottingham.ac.uk with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <ppxwh2@nottingham.ac.uk>)
        id 1igqiS-0002nX-9S; Mon, 16 Dec 2019 13:47:16 +0000
To:     wslkml@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <CAJJUZdw-mB486+Kckq4waE8sa=JD58789Nkt=5-S65XCVDeYcw@mail.gmail.com>
Subject: Re: driver compilation problem / rdtsc error
From:   Will Hardiman <william.hardiman@nottingham.ac.uk>
Message-ID: <4e02196c-215a-b647-8d0b-ce8cd60ad443@nottingham.ac.uk>
Date:   Mon, 16 Dec 2019 13:47:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAJJUZdw-mB486+Kckq4waE8sa=JD58789Nkt=5-S65XCVDeYcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-SASI-RCODE: 200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having the same problem with the pi_stage kernel module, using 
kernel v5.0.0-37, how did you solve your problem?

Thanks,

Will

-- 
Will Hardiman

PhD student in Bio Optics, Optics and Photonics Group,
Faculty of Engineering,
University of Nottingham




This message and any attachment are intended solely for the addressee
and may contain confidential information. If you have received this
message in error, please contact the sender and delete the email and
attachment. 

Any views or opinions expressed by the author of this email do not
necessarily reflect the views of the University of Nottingham. Email
communications with the University of Nottingham may be monitored 
where permitted by law.




