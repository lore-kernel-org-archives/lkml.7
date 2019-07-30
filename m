Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD7C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E76206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bC6D72d7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfG3WaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:30:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40534 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfG3WaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:30:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UMSiaL124824;
        Tue, 30 Jul 2019 22:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DnsYsIWegt9l1UBcTIBMqkBPp/Z4PoSnSabztVhnAYw=;
 b=bC6D72d7moiLsAalyEGzAE+j0Ynu+OUEM3Ra7c6sx6serKTsuGlnXMo+1i9GP/jAerti
 8E3vbnXpfk6XO1EEMgrbBSTUmuA+F6eTUtD6kbFx8VinFtAttBSvmzXOe941gLu0EZM5
 jqZ1Nn1b2M0aIuaHbK2RowJMWjtOKf/5TDqP3+0BmC9BE5wsXY7ukpikSfMc9/sM8rVL
 lpo6C8BGU96iIgupFo3nxmueooJUAdVWhR47DZ5ZofT0useuifdh/LWOPlIdXclE3l07
 VKToN/Xu0cM81Dzakceow7uAlEc2YQzwGlD0kThggxREtiiLft49UccAD5wxmxk9IqbQ Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u0e1tsg9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 22:29:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UMSGPW017624;
        Tue, 30 Jul 2019 22:29:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u0bque8un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 22:29:47 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6UMTkOV022728;
        Tue, 30 Jul 2019 22:29:46 GMT
Received: from dhcp-10-10-45-25.usdhcp.oraclecorp.com (/10.10.45.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 15:29:45 -0700
Subject: Re: [PATCH 7/7] tracing: Un-export ftrace_set_clr_event
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
References: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
 <1564444954-28685-8-git-send-email-divya.indi@oracle.com>
 <20190729205138.689864d2@gandalf.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <8e50d405-a4fb-fadf-509e-157b031d7542@oracle.com>
Date:   Tue, 30 Jul 2019 15:29:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729205138.689864d2@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300225
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 7/29/19 5:51 PM, Steven Rostedt wrote:
> On Mon, 29 Jul 2019 17:02:34 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>> Use "trace_array_set_clr_event" to enable/disable events to a trace
>> array from other kernel modules/components.
>> Hence, we no longer need to have ftrace_set_clr_event as an exported API.
> Hmm, this simply reverts patch 1. Why have patch 1 and this patch in
> the first place?

Right! First patch fixes issues in a previous commit and then this patch 
reverts the part of previous commit that required the fix.

We can eliminate the first patch if it seems counter intuitive.


Thanks,

Divya

>
> -- Steve
>
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>> Reviewed-By: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
