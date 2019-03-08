Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE83C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BDA20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hz1QMyZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfCHMGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:06:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41864 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:06:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28BxH0n073639;
        Fri, 8 Mar 2019 12:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6gunmPRtyzB5p7Uqgto3EMIlLRmF1oYfz9uTONoRbZw=;
 b=hz1QMyZrEiitthXmvZXzMwwlqT43iY/18jjgb9Jf46Ern9xXv7lQ11WYsdTBvF8vt11z
 XRadEL0Bheei6b710dCZDpwEPH8Q2X+6vcFvmyHsrxEyd+wmiMjmuJo7xQJ0lI6bRSyS
 5k75X3o4IRDlvTzDUYaeUO3m4p7KIfXkSaG83TMHswHU7wyXe/ha1olSGWiHQrvPWIRw
 0bNSyo6rLJs4laPjR0ac5eMwDBt4tgedU6rjyf6nZyYRZ7lTE9xRNxLKw1vLTqBik2Bs
 Lm9zSp0vd43yVTjNyunsNM43ajLDbecFFeAd+JXcIsg2Kv/LIVlpuAmGWDQ7yW5ykeiC Ow== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qyjfrytbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 12:05:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x28C5bGL005253
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 12:05:37 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x28C5aVl023568;
        Fri, 8 Mar 2019 12:05:37 GMT
Received: from tomti.i.net-space.pl (/10.175.206.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 04:05:36 -0800
Date:   Fri, 8 Mar 2019 13:05:31 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, corbet@lwn.net, hpa@zytor.com, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, konrad.wilk@oracle.com,
        mfleming@suse.com, ross.philipson@oracle.com
Subject: Re: [PATCH] doc: add boot protocol 2.13 description to
 Documentation/x86/boot.txt
Message-ID: <20190308120531.4qn2g3ahm2v2awb2@tomti.i.net-space.pl>
References: <20190308114310.25041-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308114310.25041-1-jgross@suse.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9188 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=933 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 12:43:10PM +0100, Juergen Gross wrote:
> Documentation/x86/boot.txt is missing protocol 2.13 description.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel
