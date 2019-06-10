Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AC6C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3392085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbfFJNli convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:41:38 -0400
Received: from elephants.elehost.com ([216.66.27.132]:11249 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390156AbfFJNlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:41:37 -0400
X-Greylist: delayed 820 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 09:41:37 EDT
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x5ADRpeT017377
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Jun 2019 09:27:51 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqq36klozfu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36klozfu.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.22.0
Date:   Mon, 10 Jun 2019 09:27:45 -0400
Message-ID: <018b01d51f90$4d394c10$e7abe430$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF6jAlHAj4+VvQmlQVIepong1ytu6dKBuKg
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 7, 2019 5:31 PM, Junio C Hamano wrote:
> The latest feature release Git v2.22.0 is now available at the
> usual places.  It is comprised of 745 non-merge commits since
> v2.21.0, contributed by 74 people, 18 of which are new faces.

Report from NonStop tests:
t7519 subtest 25 still fails on first execution but not on second. 
t9001 subtests 33, 82, 118, 119, 146 fail. We have no normal sendmail on platform.
t9020, t9600, t9601, t9602 all fail - we have no SVN. I may be able to handle exclusions for the next release.

So essentially, no change from previous releases other than t7519 being wonky. This is a pass. Thanks for all hard work from the team.

Regards,
Randall


