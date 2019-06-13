Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27979C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC4D21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443509;
	bh=yRhMIYFUCpacV6Ght0w624eU8wQn2sqoRRju74I0NjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kYgV211mGikTkuTOOTQ6oDju/GoTGKB3XtP6J0VtrP1oNM55RzlMP39CDFwG35XT2
	 9v3BHYBymtlGcOdYTmUe/AhmkfeJwBBhKT5z0yWfvZ79Up01tOt/ST/61tr71Pghl8
	 4S1ek/GZGWxTIK1RlC/Ozn9JMkP4dDqA+AcLxxGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbfFMQbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:31:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:44832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730868AbfFMIXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:23:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4C40AD5E;
        Thu, 13 Jun 2019 08:23:18 +0000 (UTC)
Date:   Thu, 13 Jun 2019 10:23:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [RESEND PATCH v2] mm/oom_killer: Add task UID to info message on
 an oom kill
Message-ID: <20190613082318.GB9343@dhcp22.suse.cz>
References: <1560362273-534-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560362273-534-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-06-19 13:57:53, Joel Savitz wrote:
> In the event of an oom kill, useful information about the killed
> process is printed to dmesg. Users, especially system administrators,
> will find it useful to immediately see the UID of the process.

Could you be more specific please? We already print uid when dumping
eligible tasks so it is not overly hard to find that information in the
oom report. Well, except when dumping of eligible tasks is disabled. Is
this what you are after?

Please always be specific about usecases in the changelog. A terse
statement that something is useful doesn't tell much very often.

Thanks!
-- 
Michal Hocko
SUSE Labs
